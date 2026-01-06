// Cat Cafe Web Application - INTENTIONALLY VULNERABLE
// DO NOT use this code in production!

const express = require('express');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
const sqlite3 = require('sqlite3').verbose();
const path = require('path');
const fs = require('fs');

const app = express();
const PORT = 3000;

// Middleware
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(cookieParser());
app.use(express.static('public'));
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// Initialize database
const db = new sqlite3.Database(':memory:');

// Create tables and insert sample data
db.serialize(() => {
    // Users table
    db.run(`CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE,
        password TEXT,
        role TEXT DEFAULT 'user',
        secret_token TEXT
    )`);

    // Cats table
    db.run(`CREATE TABLE cats (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        breed TEXT,
        description TEXT,
        image TEXT,
        secret_location TEXT
    )`);

    // Comments table
    db.run(`CREATE TABLE comments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cat_id INTEGER,
        username TEXT,
        comment TEXT,
        FOREIGN KEY(cat_id) REFERENCES cats(id)
    )`);

    // Insert sample data
    db.run(`INSERT INTO users (username, password, role, secret_token) VALUES
        ('admin', 'meow123', 'admin', 'FLAG{4dm1n_4cc3ss_gr4nt3d}'),
        ('alice', 'cat_lover', 'user', 'user_token_alice'),
        ('bob', 'kitten123', 'user', 'user_token_bob')`);

    db.run(`INSERT INTO cats (name, breed, description, image, secret_location) VALUES
        ('Whiskers', 'Persian', 'Fluffy white cat who loves naps', 'whiskers.jpg', 'Behind the bookshelf'),
        ('Shadow', 'Black Cat', 'Mysterious and playful', 'shadow.jpg', 'In the basement'),
        ('Mittens', 'Tabby', 'Missing! Last seen near the treat cabinet', 'mittens.jpg', 'SECRET: In the ventilation system - FLAG{m1tt3ns_f0und}'),
        ('Luna', 'Siamese', 'Vocal and friendly', 'luna.jpg', 'By the window'),
        ('Tiger', 'Orange Tabby', 'Energetic and curious', 'tiger.jpg', 'On the cat tower')`);
});

// Routes

// Home page
app.get('/', (req, res) => {
    res.render('index', { user: req.cookies.user });
});

// 3D Escape Room
app.get('/escape-room-3d', (req, res) => {
    res.render('escape_room_3d');
});

// Challenge 1: SQL Injection - Login
app.get('/login', (req, res) => {
    res.render('login', { error: null, user: req.cookies.user });
});

// VULNERABLE: SQL Injection
app.post('/login', (req, res) => {
    const { username, password } = req.body;

    // INTENTIONALLY VULNERABLE - Direct string concatenation
    const query = `SELECT * FROM users WHERE username = '${username}' AND password = '${password}'`;

    db.get(query, (err, user) => {
        if (err) {
            res.render('login', { error: 'Database error: ' + err.message });
        } else if (user) {
            res.cookie('user', user.username);
            res.cookie('role', user.role);
            if (user.role === 'admin') {
                res.cookie('admin_token', user.secret_token);
            }
            res.redirect('/cats');
        } else {
            res.render('login', { error: 'Invalid username or password' });
        }
    });
});

// Challenge 2: XSS - Cat listing
app.get('/cats', (req, res) => {
    db.all('SELECT * FROM cats', (err, cats) => {
        if (err) {
            res.status(500).send('Database error');
        } else {
            res.render('cats', { cats, user: req.cookies.user });
        }
    });
});

// Challenge 3: XSS - Individual cat page with comments
app.get('/cat/:id', (req, res) => {
    const catId = req.params.id;

    db.get('SELECT * FROM cats WHERE id = ?', [catId], (err, cat) => {
        if (err || !cat) {
            res.status(404).send('Cat not found');
        } else {
            db.all('SELECT * FROM comments WHERE cat_id = ?', [catId], (err, comments) => {
                res.render('cat_detail', { cat, comments: comments || [], user: req.cookies.user });
            });
        }
    });
});

// VULNERABLE: XSS - No sanitization of comment
app.post('/cat/:id/comment', (req, res) => {
    const catId = req.params.id;
    const { comment } = req.body;
    const username = req.cookies.user || 'Anonymous';

    db.run('INSERT INTO comments (cat_id, username, comment) VALUES (?, ?, ?)',
        [catId, username, comment], (err) => {
        if (err) {
            res.status(500).send('Error posting comment');
        } else {
            res.redirect(`/cat/${catId}`);
        }
    });
});

// Challenge 4: Directory Traversal - File viewing
app.get('/files', (req, res) => {
    const availableFiles = [
        'menu.txt',
        'schedule.txt',
        'staff.txt'
    ];
    res.render('files', { files: availableFiles, user: req.cookies.user });
});

// VULNERABLE: Directory Traversal
app.get('/view-file', (req, res) => {
    const filename = req.query.file;

    if (!filename) {
        return res.status(400).send('No file specified');
    }

    // INTENTIONALLY VULNERABLE - No path sanitization
    const filePath = path.join(__dirname, 'data', filename);

    fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
            res.status(404).send('File not found or error reading file');
        } else {
            res.render('view_file', { filename, content: data, user: req.cookies.user });
        }
    });
});

// Challenge 5: Authentication Bypass - Admin panel
app.get('/admin', (req, res) => {
    // VULNERABLE: Only checks cookie, easy to bypass
    if (req.cookies.role === 'admin') {
        db.all('SELECT username, role, secret_token FROM users', (err, users) => {
            res.render('admin', { users: users || [], user: req.cookies.user });
        });
    } else {
        res.status(403).render('error', {
            message: 'Access Denied: Admin only!',
            user: req.cookies.user
        });
    }
});

// API endpoint for challenge verification
app.get('/api/verify/:challenge', (req, res) => {
    const challenge = req.params.challenge;

    switch(challenge) {
        case 'sql_injection':
            if (req.cookies.admin_token && req.cookies.admin_token.includes('FLAG{')) {
                res.json({ success: true, flag: req.cookies.admin_token });
            } else {
                res.json({ success: false, message: 'Not logged in as admin' });
            }
            break;

        case 'xss':
            // Check if XSS payload was executed (simulated)
            res.json({ success: true, message: 'Check if your XSS payload executes!' });
            break;

        case 'directory_traversal':
            const file = req.query.file;
            if (file && file.includes('secret')) {
                res.json({ success: true, flag: 'FLAG{tr4v3rs4l_m4st3r}' });
            } else {
                res.json({ success: false, message: 'Find the secret file!' });
            }
            break;

        case 'auth_bypass':
            if (req.cookies.role === 'admin') {
                res.json({ success: true, flag: 'FLAG{4uth_byp4ss3d}' });
            } else {
                res.json({ success: false, message: 'Not authenticated as admin' });
            }
            break;

        default:
            res.json({ success: false, message: 'Unknown challenge' });
    }
});

// Logout
app.get('/logout', (req, res) => {
    res.clearCookie('user');
    res.clearCookie('role');
    res.clearCookie('admin_token');
    res.redirect('/');
});

// Error handler
app.use((req, res) => {
    res.status(404).render('error', {
        message: 'Page not found',
        user: req.cookies.user
    });
});

// Start server
app.listen(PORT, () => {
    console.log(`
    ╔════════════════════════════════════════════════════╗
    ║  🐱 Cat Cafe Web Application - Running!          ║
    ╚════════════════════════════════════════════════════╝

    ⚠️  WARNING: This is a VULNERABLE application!

    Server running at: http://localhost:${PORT}

    Available Challenges:
    • SQL Injection: /login
    • XSS: /cats and /cat/:id
    • Directory Traversal: /files
    • Auth Bypass: /admin

    Press Ctrl+C to stop the server.
    `);
});
