const express = require("express");
const admin = require("firebase-admin");
const multer = require("multer");
const { enviarCorreo } = require("../models/emailService.js");
const Blog = require("../models/Blog.js");
const Login = require("../models/User.js");
const { checkSessionActive } = require("../middlewares/checkSessionActive.js");
const jwt = require("jsonwebtoken");
const session = require("express-session");
const crypto = require("crypto");
const secretKey = crypto.randomBytes(32).toString("hex");
const speakeasy = require("speakeasy");
const { SitemapStream, streamToPromise } = require("sitemap");
const dotenv = require("dotenv");
dotenv.config();

const routes = ["/", "/about", "/contact", "/resume", "/portfolio", "/blog"]; // for sitemap generation


//firebase config
const serviceAccounts = {
  "type": "service_account",
  "project_id": process.env.FIREBASE_PROJECT_ID,
  "private_key_id": process.env.FIREBASE_PRIVATE_KEY_ID,
  "private_key": process.env.FIREBASE_PRIVATE_KEY,
  "client_email": process.env.FIREBASE_CLIENT_EMAIL,
  "client_id": process.env.FIREBASE_CLIENT_ID,
  "auth_uri": process.env.FIREBASE_AUTH_URI,
  "token_uri": process.env.FIREBASE_TOKEN_URI,
  "auth_provider_x509_cert_url": process.env.FIREBASE_AUTH_PROVIDER_X509_CERT_URL,
  "client_x509_cert_url": process.env.FIREBASE_CLIENT_X509_CERT_URL,
  "universe_domain": process.env.FIREBASE_UNIVERSE_DOMAIN
};



admin.initializeApp({
  credential: admin.credential.cert(serviceAccounts),
  storageBucket: process.env.FIREBASE_STORAGE_BUCKET,
});

const storage = admin.storage().bucket();
const router = express.Router();

// Utility function to determine content type based on file extension
function getContentType(filename) {
  const ext = filename.split(".").pop();
  switch (ext) {
    case "jpg":
    case "jpeg":
    case "png":
      return "image/jpeg";
    case "mp4":
      return "video/mp4";
    default:
      return "application/octet-stream";
  }
}

// Multer middleware for file upload
const upload = multer();

// Route for handling file uploads
router.post("/upload", upload.single("file"), async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).render("editor", { error: "No file uploaded" });
    }

    const file = req.file;
    const contentType = getContentType(file.originalname);
    const blob = storage.file(`uploads/${file.originalname}`);

    const blobStream = blob.createWriteStream({
      resumable: false,
      metadata: {
        contentType: contentType,
      },
    });

    blobStream.on("finish", async () => {
      try {
        const [url] = await blob.getSignedUrl({
          action: "read",
          expires: "01-01-2100",
        });

        res.json({ url });
      } catch (err) {
        console.error("Error generating signed URL:", err);
        return res
          .status(500)
          .render("editor", { error: "Error generating signed URL" });
      }
    });

    blobStream.on("error", (err) => {
      console.error("Error uploading to Firebase Storage:", err);
      return res
        .status(500)
        .render("editor", { error: "Error uploading to Firebase Storage" });
    });

    blobStream.end(file.buffer);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal server error" });
  }
});

// Session middleware setup
router.use(
  session({
    secret: secretKey,
    resave: true,
    saveUninitialized: true,
  })
);

// Editor route with session check
router.get(
  "/editor",
  async (req, res, next) => {
    checkSessionActive(req, res, next, secretKey);
  },
  async (req, res) => {
    if (!req.session.token) {
      return res.redirect("/login");
    }

    var us = req.session.username;

    const user = await Login.findOne({ us });

    const userInfo = {
      id: user._id,
      username: user.Username,
      email: user.Email,
      image: user.Image,
    };
    res.render("editor", { userInfo });
  }
);

// Index route
router.get("/", async (req, res) => {
  try {
    const blogPosts = await Blog.find();
    res.render("index.ejs", { blogPosts });
  } catch (error) {
    return res.status(500).render("login", { error: "Internal server error" });
  }
});

// Login route with session check
router.get(
  "/login",
  (req, res, next) => {
    checkSessionActive(req, res, next, secretKey);
  },
  async (req, res) => {
    try {
      if (req.session.token) {
        return res.redirect("/admin");
      }
      const users = await Login.find();
      res.render("login.ejs", { users });
    } catch (error) {
      return res
        .status(500)
        .render("login", { error: "Error to get user data" });
    }
  }
);

// Verify route for login
router.post("/verify", async (req, res) => {
  const { username, userpassword } = req.body;

  try {
    const user = await Login.findOne({ Username: username });

    if (!user || userpassword !== user.Password) {
      return res
        .status(500)
        .render("login", { error: "Username or password incorrect" });
    }
    res.render("verifyAccount", { Username: username });
  } catch (error) {
    return res.status(500).render("login", { error: "Error to validate user" });
  }
});

// VerifyAccount route for login
router.post("/VerifyAccount", async (req, res) => {
  const { username, totp } = req.body;

  try {
    const user = await Login.findOne({ username });
    req.session.username = username;

    if (!user) {
      return res
        .status(500)
        .render("verifyAccount", { username, error: "User not found" });
    }

    const verified = speakeasy.totp.verify({
      secret: user.FactorA,
      encoding: "base32",
      token: totp,
    });

    if (!verified) {
      return res
        .status(500)
        .render("verifyAccount", { username, error: "Error verifying 2FA" });
    }

    const usuario = { id: user._id, nombre: user.Username };
    const token = jwt.sign(usuario, secretKey, { expiresIn: "1d" });
    req.session.token = token;
    req.session.username = username;

    res.redirect("/admin");

    enviarCorreo(
      user.Email,
      "Inicio de sesión de " + user.Username + " en VicentCodes.com",
      "Se ha detectado un inicio de sesión en VicentCodes.com",
      req.ip
    );
  } catch (error) {
    console.error(error);
  }
});

// Admin route with session check
router.get(
  "/admin",
  async (req, res, next) => {
    checkSessionActive(req, res, next, secretKey);
  },
  async (req, res) => {
    try {
      if (!req.session.token) {
        return res.redirect("/login");
      }

      var us = req.session.username;

      const user = await Login.findOne({ us });

      const userInfo = {
        id: user._id,
        username: user.Username,
        email: user.Email,
        image: user.Image,
      };

      res.render("admin", { userInfo });
    } catch (error) {
      return res
        .status(500)
        .render("admin", { error: "Internal server error" });
    }
  }
);

// SendB route for admin
router.post(
  "/sendB",
  async (req, res, next) => {
    checkSessionActive(req, res, next, secretKey);
  },
  async (req, res) => {
    try {
      if (!req.session.token) {
        return res.redirect("/login");
      }

      // Working :D
      const nuevoBlog = new Blog({
        Title: req.body.title,
        Description: "",
        Date: new Date().toLocaleDateString(),
        Image: "",
        Tag: "",
        Content: req.body.content,
      });

      try {
        await nuevoBlog.save();
      } catch (error) {
        console.error(error);
        res.status(500).send("Error to save blog post");
      }
    } catch (error) {
      return res
        .status(500)
        .render("admin", { error: "Internal server error" });
    }
  }
);

// Other routes (about, contact, resume, portfolio, blog)
const renderOtherRoutes = async (req, res) => {
  try {
    const blogPosts = await Blog.find();
    res.render("index.ejs", { blogPosts });
  } catch (error) {
    return res.status(500).render("login", { error: "Internal server error" });
  }
};

router.get("/about", renderOtherRoutes);
router.get("/contact", renderOtherRoutes);
router.get("/resume", renderOtherRoutes);
router.get("/portfolio", renderOtherRoutes);
router.get("/blog", renderOtherRoutes);

// Sitemap route
router.get("/sitemap.xml", async (req, res) => {
  try {
    res.header("Content-Type", "application/xml");

    // Create a new sitemap and configure it
    const sitemapStream = new SitemapStream({
      hostname: "https://VicentCodes.com",
    });

    // Iterate over the routes and write them to the sitemap
    routes.forEach((route) => {
      sitemapStream.write({ url: route, changefreq: "daily", priority: 0.7 });
    });

    // End the stream
    sitemapStream.end();

    // Convert the sitemap stream to a string and send it as the response
    const sitemapString = await streamToPromise(sitemapStream);
    res.send(sitemapString);
  } catch (error) {
    console.error(error);
    res.status(500).end();
  }
});

module.exports = router;
