const express = require("express");
const mysql = require("mysql");
const cors = require("cors");

const app = express();
app.use(cors()); // Allow frontend requests
app.use(express.json());

const db = mysql.createConnection({
    host: "localhost",
    user: "root",       // Change as needed
    password: "",       // Change as needed
    database: "perfume_shop"
});

db.connect((err) => {
    if (err) throw err;
    console.log("Connected to database");
});

// API to get products by category
app.get("/products/:brand", (req, res) => {
    const brand = req.params.brand;
    const query = "SELECT * FROM products WHERE brand = ?";
    db.query(query, [brand], (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});

app.listen(3000, () => {
    console.log("Server running on port 3000");
});

// API to insert a new product
app.post("/products", (req, res) => {
    const { brand, title, description, price, cut_price, image } = req.body;

    if (!brand || !title || !description || !price || !cut_price || !image) {
        return res.status(400).json({ error: "All fields are required!" });
    }

    const query = "INSERT INTO products (brand, title, description, price, cut_price, image) VALUES (?, ?, ?, ?, ?, ?)";
    db.query(query, [brand, title, description, price, cut_price, image], (err, result) => {
        if (err) {
            console.error("Error inserting product:", err);
            return res.status(500).json({ error: "Database error" });
        }
        res.status(201).json({ message: "Product added successfully!", id: result.insertId });
    });
});
// require('dotenv').config();
// const express = require('express');
// const mysql = require('mysql2');
// const bodyParser = require('body-parser');
// const cors = require('cors');

// const app = express();
// const port = 3000;

// // Middleware
// app.use(cors());
// app.use(bodyParser.json());
// app.use(express.static('public')); // Serve static HTML files

// // MySQL Connection
// const db = mysql.createConnection({
//   host: process.env.DB_HOST,
//   user: process.env.DB_USER,
//   password: process.env.DB_PASSWORD,
//   database: process.env.DB_NAME,
// });

// db.connect(err => {
//   if (err) throw err;
//   console.log('Connected to MySQL');
// });

// // 🟢 Insert User (POST)
// app.post('/api/users', (req, res) => {
//   const { name, email } = req.body;
//   const sql = 'INSERT INTO users (name, email) VALUES (?, ?)';
//   db.query(sql, [name, email], (err, result) => {
//     if (err) return res.status(500).json({ error: err.message });
//     res.json({ message: 'User added successfully', id: result.insertId });
//   });
// });

// // 🔵 Get All Users (GET)
// app.get('/api/users', (req, res) => {
//   db.query('SELECT * FROM users', (err, results) => {
//     if (err) return res.status(500).json({ error: err.message });
//     res.json(results);
//   });
// });

// // Start Server
// app.listen(port, () => console.log(`Server running at http://localhost:${port}`));

/*
2️⃣ Test API with Postman
Method: POST
URL: http://localhost:3000/products
Headers:
pgsql
Copy
Edit
Content-Type: application/json
Body (JSON format):
json
Copy
Edit
{
  "brand": "J.",
  "title": "New Perfume",
  "description": "A luxurious new fragrance.",
  "price": 55.00,
  "cut_price": 65.00,
  "image": "../Images/J/New-Perfume.jpg"
}
Click "Send" → Should return:
json
Copy
Edit
{
  "message": "Product added successfully!",
  "id": 5
}
📌 3️⃣ Add a Frontend Form to Insert Products
Modify your HTML page to add a form:

html
Copy
Edit
<form id="addProductForm">
    <input type="text" id="brand" placeholder="Brand" required>
    <input type="text" id="title" placeholder="Title" required>
    <input type="text" id="description" placeholder="Description" required>
    <input type="number" id="price" placeholder="Price" required>
    <input type="number" id="cut_price" placeholder="Cut Price" required>
    <input type="text" id="image" placeholder="Image URL" required>
    <button type="submit">Add Product</button>
</form>

<div id="message"></div>
📌 4️⃣ Handle Form Submission in JavaScript
Now, write JavaScript to send form data to your API:

javascript
Copy
Edit
document.getElementById("addProductForm").addEventListener("submit", async function (event) {
    event.preventDefault();

    const brand = document.getElementById("brand").value;
    const title = document.getElementById("title").value;
    const description = document.getElementById("description").value;
    const price = document.getElementById("price").value;
    const cut_price = document.getElementById("cut_price").value;
    const image = document.getElementById("image").value;

    const productData = { brand, title, description, price, cut_price, image };

    try {
        const response = await fetch("http://localhost:3000/products", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(productData)
        });

        const result = await response.json();
        document.getElementById("message").innerText = result.message;

        if (response.ok) {
            document.getElementById("addProductForm").reset(); // Clear form
            setCategory(brand); // Refresh products display
        }

    } catch (error) {
        console.error("Error adding product:", error);
    }
});
📌 5️⃣ Final Steps
Restart your Node.js server
sh
Copy
Edit
node server.js
Fill out the form & Submit
Check your database (Run SELECT * FROM products; in MySQL)
See the product displayed on your site! 🎉
🎯 Features Added
✅ Database Integration (Fetch + Insert)
✅ Dynamic Product Display
✅ User-Friendly Form for Adding Products

This setup makes your perfume shop fully dynamic and database-driven! 🚀 Let me know if you need improvements. 😊*/