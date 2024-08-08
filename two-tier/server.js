const express = require('express');
const bodyParser = require('body-parser');
const sqlite3 = require('sqlite3').verbose();
const path = require('path');
const os = require('os');
const app = express();
const port = 3000;

// Middleware
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));

// SQLite database setup (file-based)
const db = new sqlite3.Database('./contacts.db'); // File-based database

db.serialize(() => {
    db.run("CREATE TABLE IF NOT EXISTS contacts (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, phone TEXT, message TEXT)");
});

// Serve the HTML form
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Handle form submission
app.post('/submit', (req, res) => {
    const { name, email, phone, message } = req.body;
    db.run('INSERT INTO contacts (name, email, phone, message) VALUES (?, ?, ?, ?)', [name, email, phone, message], function(err) {
        if (err) {
            return console.log(err.message);
        }
        res.send('Thank you for your message!');
    });
});

// Route to fetch and display all records from the contacts table
app.get('/contacts', (req, res) => {
    db.all('SELECT * FROM contacts', [], (err, rows) => {
        if (err) {
            throw err;
        }
        res.json(rows);
    });
});

// Get local IP address
function getLocalIpAddress() {
    const interfaces = os.networkInterfaces();
    for (const name of Object.keys(interfaces)) {
        for (const iface of interfaces[name]) {
            if (iface.family === 'IPv4' && !iface.internal) {
                return iface.address;
            }
        }
    }
    return '127.0.0.1'; // Fallback to localhost
}

// Start the server
app.listen(port, () => {
    const ip = getLocalIpAddress();
    console.log(`Server running. Check at PublicIP:3000`);
});
