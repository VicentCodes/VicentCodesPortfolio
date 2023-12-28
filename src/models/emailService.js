const nodemailer = require('nodemailer');
const { format } = require('date-fns');
const axios = require('axios');
const dotenv = require("dotenv");
dotenv.config();
const transporter = nodemailer.createTransport({
  host: 'mail.spacemail.com',
  port: 465,
  secure: true, 
  auth: {
    user: process.env.emailUser,
    pass: process.env.emailPass,
  },
});

async function obtenerInfoIP(ip) {
  try {
    const response = await axios.get(`https://ipinfo.io/${ip}?token=${process.env.ipinfoToken}`);
    return response.data;
  } catch (error) {

    return {};
  }
}

async function enviarCorreo(destinatario, asunto, mensaje, ip) {
  const fechaFormateada = format(new Date(), "EEEE dd 'de' MMMM yyyy 'a las' HH:mm");

  const infoIP = await obtenerInfoIP(ip);

  const mensajeFinal = `${mensaje}\nFecha: ${fechaFormateada}\nIP: ${ip}\nUbicación aproximada: ${infoIP.city}, ${infoIP.region}, ${infoIP.country}`;

  const mailOptions = {
    from: `VicentCodes.com <${process.env.emailPass}>`,
    to: destinatario,
    subject: asunto,
    text: mensajeFinal,
  };

  return new Promise((resolve, reject) => {
    transporter.sendMail(mailOptions, (error, info) => {
      if (error) {
        reject(error);
      } else {
        resolve(info.response);
      }
    });
  });
}

module.exports = { enviarCorreo };
