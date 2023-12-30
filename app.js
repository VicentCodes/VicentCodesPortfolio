const express = require("express");
const app = express();
const path = require("path");
const bodyParser = require("body-parser");
const IndexRoutes = require("./src/routers/index.js");
app.set('trust proxy', true);
const dotenv = require('dotenv');
const log = require('morgan');
const analytics = require('@vercel/analytics');
dotenv.config();
const mongoURL = process.env.MONGO_URL;

app.use(express.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.set("port", process.env.PORT || 3000);
app.use(log('dev'));


app.use((req, res, next) => {
  analytics.inject();
  next();
});

const { default: mongoose } = require("mongoose");

app.set("views", path.join(__dirname, "src", "views"));
app.use(express.static(path.join(__dirname, "src", "public")));

app.set("view engine", "ejs");

app.use("/", IndexRoutes);
app.use((req, res, next) => {
  res.status(404).render('404');
});

app.listen(app.get("port"), () => {
  console.log("El servidor está funcionando en el puerto", app.get("port"));
});

mongoose
  .connect(mongoURL)
  .then((bd) => console.log('BD Mongo "VicentCodePortfolio" conectado'))
  .catch((err) => console.log(err));
