const express = require("express");
const { Pool } = require("pg");
const cors = require("cors");
const bodyParser = require("body-parser");
const path = require("path");

const app = express();
const PORT = process.env.PORT || 3000;

// Serve static files
app.use(express.static(path.join(__dirname, "HTML")));
app.use("/Images", express.static(path.join(__dirname, "Images")));

// Middleware
app.use(cors());
app.use(bodyParser.json());

// PostgreSQL Pool Connection using Railway's DATABASE_URL
const pool = new Pool({
    connectionString: process.env.DATABASE_URL,
    ssl: process.env.DATABASE_URL ? { rejectUnauthorized: false } : false
});

// Test Database Connection on Startup
async function connectToDB() {
    try {
        const client = await pool.connect();
        console.log("✅ Connected to PostgreSQL Database");
        client.release();
    } catch (err) {
        console.error("❌ PostgreSQL DB connection error:", err);
        process.exit(1);
    }
}
connectToDB();

// 🧴 API to fetch products by category
app.get("/api/products", async (req, res) => {
    try {
        const result = await pool.query(`SELECT * FROM Perfumes_Display`);
        console.log("✅ Fetched Data:", result.rows);
        res.json(result.rows);
    } catch (error) {
        console.error("Error fetching products:", error);
        res.status(500).json({ error: "Failed to load products" });
    }
});

// GET route to fetch all perfumes
app.get('/api/perfumes', async (req, res) => {
    try {
        const result = await pool.query(`SELECT * FROM PERFUME_V ORDER BY PerfumeId ASC`);
        console.log("✅ Fetched Data:", result.rows);
        res.json(result.rows);
    } catch (err) {
        console.error("❌ Database query error:", err);
        res.status(500).json({ error: "Internal Server Error" });
    }
});

// GET route to fetch incomplete orders
app.get('/api/orderin', async (req, res) => {
    try {
        const result = await pool.query(`SELECT * FROM INCOMPLETEORDERS_V`);
        console.log("✅ Fetched Data:", result.rows);
        res.json(result.rows);
    } catch (err) {
        console.error("❌ Database query error:", err);
        res.status(500).json({ error: "Internal Server Error" });
    }
});

// GET route to fetch all completed orders
app.get('/api/orderc', async (req, res) => {
    try {
        const result = await pool.query(`SELECT * FROM COMPLETEORDERS_V`);
        console.log("✅ Fetched Data:", result.rows);
        res.json(result.rows);
    } catch (err) {
        console.error("❌ Database query error:", err);
        res.status(500).json({ error: "Internal Server Error" });
    }
});

app.post('/api/updateOrderStatus', async (req, res) => {
    const { orderId, newStatus } = req.body;

    if (!orderId || !newStatus) {
        return res.status(400).json({ error: 'Order ID and new status are required.' });
    }
    try {
        // Calling PostgreSQL function or procedure
        const result = await pool.query(
            `SELECT update_order_and_payment_status($1, $2)`,
            [orderId, newStatus]
        );

        res.status(200).json({
            message: `Order status for Order ID ${orderId} updated to "${newStatus}".`,
            result: result.rows,
        });
    } catch (err) {
        console.error('❌ Error executing database function:', err);
        res.status(500).json({ error: 'Failed to update order status.' });
    }
});

app.get('/api/perfumegender', async (req, res) => {
    const { gender } = req.query;
    try {
        const query = `SELECT * FROM PERFUMES_V WHERE LOWER(GENDERNAME) = LOWER($1)`;
        const result = await pool.query(query, [gender]);
        res.json(result.rows);
    } catch (err) {
        console.error("❌ Error fetching filtered products:", err);
        res.status(500).json({ error: "Database query failed" });
    }
});

app.get('/api/perfumegenderFragrance', async (req, res) => {
    const { gender, fragrance } = req.query;
    try {
        const query = `
            SELECT * FROM PERFUMES_V
            WHERE LOWER(GENDERNAME) = LOWER($1)
            AND LOWER(CATEGORYNAME) = LOWER($2)`;
        const result = await pool.query(query, [gender, fragrance]);
        res.json(result.rows);
    } catch (err) {
        console.error("❌ Error fetching filtered products:", err);
        res.status(500).json({ error: "Database query failed" });
    }
});

app.get('/api/perfumefragrance', async (req, res) => {
    const { fragrance } = req.query;
    try {
        const query = `SELECT * FROM PERFUMES_V WHERE LOWER(CATEGORYNAME) = LOWER($1)`;
        const result = await pool.query(query, [fragrance]);
        res.json(result.rows);
    } catch (err) {
        console.error("❌ Error fetching filtered products:", err);
        res.status(500).json({ error: "Database query failed" });
    }
});

app.post('/api/customer/login', async (req, res) => {
    const { username, password } = req.body;

    try {
        const result = await pool.query(
            `SELECT * FROM CHECKLOGINCREDENTIALS WHERE Email = $1 AND password = $2 AND UserType = 'Customer'`,
            [username, password]
        );
        
        if (result.rows.length > 0) {
            const userID = result.rows[0].userid || result.rows[0].USERID;
            return res.status(200).json({
                success: true,
                message: 'Login successful',
                userId: userID
            });
        } else {
            return res.status(401).json({ message: 'Invalid credentials' });
        }
    } catch (err) {
        console.error('Customer Login Error:', err);
        res.status(500).json({ success: false, message: 'Internal server error' });
    }
});

// MANAGER LOGIN
app.post('/api/manager/login', async (req, res) => {
    const { managerId, username, password } = req.body;

    try {
        const result = await pool.query(
            `SELECT * FROM CHECKLOGINCREDENTIALS WHERE Email = $1 AND Password = $2 AND Userid = $3 AND UserType = 'Manager'`,
            [username, password, managerId]
        );

        if (result.rows.length > 0) {
            res.json({ success: true, message: 'Manager login successful.' });
        } else {
            res.json({ success: false, message: 'Invalid credentials for manager.' });
        }
    } catch (err) {
        console.error('Manager Login Error:', err);
        res.status(500).json({ success: false, message: 'Internal server error' });
    }
});

// REGISTER
app.post('/api/register', async (req, res) => {
    const { username, password } = req.body;

    try {
        const checkResult = await pool.query(
            `SELECT * FROM CHECKLOGINCREDENTIALS WHERE Email = $1`,
            [username]
        );

        if (checkResult.rows.length > 0) {
            return res.json({ success: false, message: 'Username already exists.' });
        }

        // Call registration function/procedure
        await pool.query(
            `SELECT RegisterProcedure($1, $2, 'Customer')`,
            [username, password]
        );

        res.json({ success: true, message: 'Registration successful.' });
    } catch (err) {
        console.error('Registration Error:', err);
        res.status(500).json({ success: false, message: 'Internal server error' });
    }
});

app.post('/place-order', async (req, res) => {
    const {
        customerID,
        perfumeID,
        packagingTypeID,
        orderedQuantity,
        firstName,
        lastName,
        phoneNumber,
        street,
        mohallah,
        city,
        province
    } = req.body;

    try {
        await pool.query(
            `SELECT PlacePerfumeOrder($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)`,
            [customerID, perfumeID, packagingTypeID, orderedQuantity, firstName, lastName, phoneNumber, street, mohallah, city, province]
        );
        res.status(200).json({ message: 'Order placed successfully!' });
    } catch (err) {
        console.error('Error placing order:', err);
        res.status(500).json({ error: err.message });
    }
});

// GET route to fetch orders for a specific customer
app.get('/api/orders', async (req, res) => {
    const customerID = req.query.customerID;

    if (!customerID) {
        return res.status(400).json({ error: 'CustomerID is required' });
    }

    try {
        const result = await pool.query(
            `SELECT PerfumeName, PerfumeDescription, PerfumeImage, TotalPrice, OrderStatus, OrderId
             FROM CustomerPerfumesView
             WHERE CustomerID = $1`,
            [customerID]
        );

        res.json(result.rows);
    } catch (err) {
        console.error("❌ Database query error:", err);
        res.status(500).json({ error: "Internal Server Error" });
    }
});

app.get('/api/receipt', async (req, res) => {
    const orderID = req.query.orderID;

    if (!orderID) {
        return res.status(400).json({ error: 'OrderID is required' });
    }

    try {
        const result = await pool.query(
            `SELECT * FROM ReceiptView WHERE OrderID = $1`,
            [orderID]
        );
        
        if (result.rows.length === 0) {
            return res.status(404).json({ error: 'Receipt not found for this OrderID' });
        }

        res.json(result.rows[0]);
    } catch (err) {
        console.error("❌ Database query error:", err);
        res.status(500).json({ error: "Internal Server Error" });
    }
});

app.post('/api/update-price', async (req, res) => {
  const { perfumeId, updatedPrice } = req.body;

  if (!perfumeId || !updatedPrice) {
    return res.status(400).json({ error: "Missing perfume ID or updated price." });
  }

  try {
    await pool.query(`SELECT UpdatePrices($1, $2)`, [perfumeId, updatedPrice]);
    res.json({ message: "Price updated successfully" });
  } catch (err) {
    console.error("Error executing procedure:", err);
    res.status(500).json({ error: "Database error" });
  }
});

app.post('/add-perfume', async (req, res) => {
  const {
    name,
    description,
    price,
    stock,
    imagePath,
    genderId,
    fragranceId
  } = req.body;

  if (!name || !description || !price || !stock || !imagePath || !genderId || !fragranceId) {
    return res.status(400).json({ success: false, message: 'All fields are required.' });
  }

  try {
    await pool.query(
      `SELECT AddPerfume($1, $2, $3, $4, $5, $6, $7)`,
      [name, description, price, stock, imagePath, fragranceId, genderId]
    );
    res.status(200).json({ success: true, message: 'Perfume added successfully.' });
  } catch (error) {
    console.error('❌ Error adding perfume:', error);
    res.status(500).json({ success: false, message: 'Database error.' });
  }
});

app.get('/api/customers', async (req, res) => {
    try {
        const result = await pool.query(`SELECT * FROM CustomersView`);
        res.json(result.rows);
    } catch (err) {
        console.error("❌ Database query error:", err);
        res.status(500).json({ error: "Internal Server Error" });
    }
});

app.get('/api/dashboard', async (req, res) => {
  try {
    const [
      topPerfumes,
      totalRevenue,
      topCustomers,
      topCities,
      incompletedOrders,
      completedOrders,
      totalOrders,
      cancelledOrders,
      totalPerfumes,
      averageOrderValue,
      lowStock
    ] = await Promise.all([

      pool.query(`SELECT PerfumeName, SUM(OrderedQuantity) AS UnitsSold, SUM(TotalPrice) AS TotalSales FROM SALESDASHBOARD GROUP BY PerfumeName ORDER BY SUM(TotalPrice) DESC LIMIT 5`),
      pool.query(`SELECT SUM(TotalPrice) AS TotalRevenue FROM SALESDASHBOARD WHERE ORDERSTATUS IN ('Delivered')`),
      pool.query(`SELECT CustomerName, City, SUM(TotalPrice) AS TotalSpent FROM SALESDASHBOARD GROUP BY CustomerName, City ORDER BY SUM(TotalPrice) DESC LIMIT 5`),
      pool.query(`SELECT City, COUNT(OrderID) AS Orders, SUM(TotalPrice) AS TotalSpent FROM SALESDASHBOARD GROUP BY City ORDER BY Count(OrderID) DESC LIMIT 5`),
      pool.query(`SELECT COUNT(*) AS TotalIncompletedOrders FROM SALESDASHBOARD WHERE ORDERSTATUS IN ('In Progress', 'Shipped')`),
      pool.query(`SELECT COUNT(*) AS TotalCompletedOrders FROM SALESDASHBOARD WHERE ORDERSTATUS = 'Delivered'`),
      pool.query(`SELECT COUNT(*) AS TotalOrders FROM SALESDASHBOARD`),
      pool.query(`SELECT COUNT(*) AS TotalCancelledOrders FROM SALESDASHBOARD WHERE ORDERSTATUS = 'Cancelled'`),
      pool.query(`SELECT COUNT(*) AS TotalPerfumes FROM PERFUME`),
      pool.query(`SELECT ROUND(AVG(TotalPrice), 2) AS AvgOrderValue FROM SALESDASHBOARD WHERE ORDERSTATUS NOT IN ('Cancelled')`),
      pool.query(`SELECT COUNT(*) AS LowStock FROM PERFUME WHERE PERFUMESTOCK <= 500`)

    ]);

    res.json({
      topPerfumes: topPerfumes.rows,
      totalRevenue: totalRevenue.rows[0].totalrevenue || totalRevenue.rows[0].TOTALREVENUE || 0,
      topCustomers: topCustomers.rows,
      topCities: topCities.rows,
      incompletedOrders: incompletedOrders.rows[0].totalincompletedorders || 0,
      completedOrders: completedOrders.rows[0].totalcompletedorders || 0,
      totalOrders: totalOrders.rows[0].totalorders || 0,
      cancelledOrders: cancelledOrders.rows[0].totalcancelledorders || 0,
      totalPerfumes: totalPerfumes.rows[0].totalperfumes || 0,
      avgOrderValue: averageOrderValue.rows[0].avgordervalue || 0,
      lowStock: lowStock.rows[0].lowstock || 0
    });

  } catch (err) {
    console.error("Error in /api/dashboard:", err);
    res.status(500).json({ error: "Database error" });
  }
})

app.post('/api/inventory-update', async (req, res) => {
  const { perfumeId, managerId, changeLog, quantityChanged, remarks } = req.body;

  try {
    await pool.query(
      `SELECT InventoryChanges($1, $2, $3, $4, $5)`,
      [perfumeId, managerId, changeLog, quantityChanged, remarks]
    );
    res.status(200).json({ message: 'Inventory update successful!' });
  } catch (err) {  // <-- Yahan 'catch (err)' aayega
    console.error(err);
    res.status(500).json({ message: 'Error updating inventory', error: err.message });
  }
});

app.listen(PORT, () => console.log(`🚀 Server running at port ${PORT}`));
const path = require('path');

// Static files (HTML, CSS, JS) ko serve karne ke liye
app.use(express.static(path.join(__dirname, '../'))); // Root folder ko public kar dega

// Agar koi root link khole toh LoginSignup.html ya Dashboard.html dikhaye
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, '../HTML/LoginSignup.html')); // Ya jo bhi aapka main page ho
});