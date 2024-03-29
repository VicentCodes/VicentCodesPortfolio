﻿
# VicentCodes Portfolio<img width="45px" src="https://vicentcodes.com/images/logos.png" />

Hey there! Welcome to my coding playground - VicentCodes! 🚀 This repository is home to the magic that powers my personal portfolio website. Let me give you the lowdown in a language that's more chat than code.

> [!WARNING] 
>And don't get annoyed with details, I created this project to enjoy web development and test and implement new technologies and functionalities.

## About this project

### Behind the Scenes

What's behind VicentCodes? It's my digital playground, where creativity meets technology. Whether it's creating blog posts, securing logins with 2FA, or just having a space to share my thoughts, this project is about making the web a little more vibrant.

### Why the Tech Stack?

I love a good tech party, and Node.js, Express, Firebase and MongoDB are the lifeblood of it. They ensure that the site is agile, secure and can handle all the cool features smoothly, and to be honest they're the ones I like the most.

### Keeping It Fun

VicentCodes Portfolio offers so much more than just code! Not only do they provide a dynamic sitemap and personalized email notifications, but the site also allows you to learn new technologies, understand existing ones, and implement them. Making mistakes is all part of the learning process, and VicentCodes is the perfect platform for that. I truly hope you'll find it just as helpful as I have!


## What's Cookin' in VicentCodes?

### The Tech Stuff
- **Node.js and Express:** They're the behind-the-scenes rockstars making the server dance.
- **Firebase:** The cool kid handling to storage.
- **MongoDB:** My go-to database for keeping things in check.
- **Multer:** The unsung hero managing file uploads with style.
- **JWT (JSON Web Tokens):** The VIP pass for user authentication.
- **Speakeasy:** Adds a dash of superhero security with two-factor authentication (2FA).
- **Sitemap:** Automatically creating a map so you never get lost.
- **dotenv:** Keeps secrets secret, like that secret handshake club.
- **EJS (Embedded JavaScript):** Makes sure everything looks snazzy on the web.

### The Real Deal

#### Security First
- **Authentication:** Because who likes uninvited guests?
- **JWT Token:** Like a golden ticket, but more secure. Won't work without it!
- **2FA (Two-Factor Authentication):** Because my website's got secrets.

#### File Fiesta
- **Multer Middleware:** Upload images, videos - you name it, we store it.
- **Firebase Storage:** Where all your uploaded goodies get VIP treatment.

#### Blog Babble
- **MongoDB Database:** Where my thoughts go to live forever.
- **tinyAPI:** The wizard behind dynamic blog generation.

#### Editor's Den
- **Editor Page:** Where the creative magic happens.
- **Image Upload:** Because pictures speak louder than words.

### The Email Express 📬
- **Nodemailer:** My email assistant.
- **Security Notifications:** Sends a virtual tap on the shoulder when someone logs in.
- **IP Information Service:** Finds out where in the world you're tuning in from.

## Environment Vibes

### Firebase Setup
Copy and paste these into your `.env` file:

```dotenv
FIREBASE_API_KEY=
FIREBASE_AUTH_DOMAIN=
FIREBASE_PROJECT_ID=
FIREBASE_STORAGE_BUCKET=
FIREBASE_MESSAGING_SENDER_ID=
FIREBASE_APP_ID=1:
FIREBASE_MEASUREMENT_ID=
```

### Firebase Admin SDK
More secret codes for the `.env` file:

```dotenv
FIREBASE_PROJECT_ID=
FIREBASE_PRIVATE_KEY_ID=
FIREBASE_PRIVATE_KEY=
FIREBASE_CLIENT_EMAIL=
FIREBASE_CLIENT_ID=
FIREBASE_AUTH_URI=
FIREBASE_TOKEN_URI=
FIREBASE_AUTH_PROVIDER_X509_CERT_URL=
FIREBASE_CLIENT_X509_CERT_URL=https:
FIREBASE_UNIVERSE_DOMAIN=
```

### MongoDB Connection
Add your MongoDB connection URL:

```dotenv
MONGO_URL=
```

### Email & IP Magic
Fill in your email credentials and IP info service token:

```dotenv
emailUser= Your email which will send the notification.
emailPass= Your email password.
ipinfoToken= Your tokenID from ipinfo.io or other service.
```

## Running the Show Locally

1. Clone the repo:

   ```bash
   git clone https://github.com/VicentCodes/VicentCodes.git
   ```

2. Install the cool stuff:

   ```bash
   npm install
   ```

3. Create a `.env` file and spill the beans.

4. Let the show begin:

   ```bash
   npm start
   ```

Head over to [http://localhost:your_port](http://localhost:your_port) and let the good times roll!

## Contact Me 📬

### Let's Connect!
Have a question, suggestion, or just want to chat? I'm all ears! Feel free to reach out using the contact form below:

[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/vicentcodes)
[![x](https://img.shields.io/badge/x-black?style=for-the-badge&logo=x&logoColor=white)](https://x.com/VicentCodes)
or email me at contact@VicentCodes.com


## Acknowledgements

- This portfolio is crafted from the V-Card by [codewithsadee](https://github.com/codewithsadee/vcard-personal-portfolio)
