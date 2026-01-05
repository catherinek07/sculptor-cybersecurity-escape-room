# 🌐 Cat Cafe Web Application

This is a deliberately vulnerable web application for the Web Security challenges.

## ⚠️ WARNING

**DO NOT deploy this application to a public server!**

This application contains intentional security vulnerabilities for educational purposes.
Only run it locally for learning.

## Setup

```bash
cd web_app
npm install
npm start
```

Access the application at: `http://localhost:3000`

## Features

- User authentication (vulnerable)
- Cat profile management
- Image upload
- Comment system
- Admin panel

## Vulnerabilities Included

- SQL Injection
- Cross-Site Scripting (XSS)
- Cross-Site Request Forgery (CSRF)
- Directory Traversal
- Authentication bypass
- File upload vulnerabilities

## Structure

```
web_app/
├── package.json
├── server.js
├── public/
│   ├── index.html
│   ├── styles.css
│   └── app.js
├── views/
│   └── (ejs templates)
└── uploads/
    └── (user uploaded files)
```

## Coming Soon!

The web application will be implemented in a future update.

🐱 Stay tuned for web security fun!
