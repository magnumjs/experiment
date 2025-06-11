const express = require('express');
const fs = require('fs');
const jwt = require('jsonwebtoken');
const app = express();
app.use(express.json());

const USERS_FILE = __dirname + '/users.json';
const JWT_SECRET = process.env.JWT_SECRET || 'supersecretkey';

app.post('/login', (req, res) => {
  const { username, password } = req.body;
  const users = JSON.parse(fs.readFileSync(USERS_FILE));
  const user = users.find(u => u.username === username && u.password === password);
  if (user) {
    const token = jwt.sign({ username }, JWT_SECRET, { expiresIn: '1h' });
    res.json({ message: 'Login successful', token });
  } else {
    res.status(401).json({ error: 'Invalid credentials' });
  }
});

app.get('/', (req, res) => {
  res.send('Node.js app is running. Use POST /login to authenticate.');
});

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`App running on port ${PORT}`);
});

