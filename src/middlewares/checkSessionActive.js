
const jwt = require("jsonwebtoken");

const checkSessionActive = (req, res, next, secretKey) => {
  const token = req.session.token;

  if (!token) {
    return next();  
  }

  jwt.verify(token, secretKey, (err, decoded) => {
    if (err) {
      return res.redirect("/login");
    }
    req.usuario = decoded;
    next();
  });
};

module.exports = {
  checkSessionActive,
};
  