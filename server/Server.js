const express = require("express");
const oracledb = require("oracledb");
const cors = require("cors");
const bodyParser = require("body-parser");
const path = require("path");

const app = express();
const PORT = 3000;

// Serve static files
app.use(express.static(path.join(__dirname, "HTML")));
app.use("/Images", express.static(path.join(__dirname, "Images")));

// Middleware
app.use(cors());
app.use(bodyParser.json());

// OracleDB Config
const dbConfig = {
    user: "system",
    password: "Sajid@143db",
    connectString: "localhost/orcl"
};

let connection;
async function connectToDB() {
    try {
        connection = await oracledb.getConnection(dbConfig);
        console.log("✅ Connected to Oracle Database");
    } catch (err) {
        console.error("❌ Oracle DB connection error:", err);
        process.exit(1);
    }
}
connectToDB();

// 🧴 API to fetch products by category
app.get("/api/products", async (req, res) => {
 
  try {
      const result = await connection.execute(
          `SELECT * FROM Perfumes_Display`,  // Case insensitive
          [], // Pass the category value as a parameter
          {
              outFormat: oracledb.OUT_FORMAT_OBJECT // Ensure this is correct
          }
      );

      console.log("✅ Fetched Data:", result.rows);
      res.json(result.rows);  // Send the result to the frontend
  } catch (error) {
      console.error("Error fetching products:", error);
      res.status(500).json({ error: "Failed to load products" });
  }
});

// GET route to fetch all employees
app.get('/api/perfumes', async (req, res) => {
    let connection;
    try {
         connection = await oracledb.getConnection(dbConfig);
        const result = await connection.execute(
            `SELECT * FROM PERFUME_V ORDER BY PerfumeId ASC`,
            [],
            {
                outFormat: oracledb.OUT_FORMAT_OBJECT // Ensure this is correct
            }
        );
        console.log("✅ Fetched Data:", result.rows);
        res.json(result.rows);
    } catch (err) {
        console.error("❌ Database query error:", err);
        res.status(500).json({ error: "Internal Server Error" });
    } finally {
        if (connection) await connection.close();
    }
});

// GET route to fetch all employees
app.get('/api/orderin', async (req, res) => {
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);
        const result = await connection.execute(
            `SELECT * FROM INCOMPLETEORDERS_V`,
            [],
            {
                outFormat: oracledb.OUT_FORMAT_OBJECT // Ensure this is correct
            }
        );
        console.log("✅ Fetched Data:", result.rows);
        res.json(result.rows);
    } catch (err) {
        console.error("❌ Database query error:", err);
        res.status(500).json({ error: "Internal Server Error" });
    } finally {
        if (connection) await connection.close();
    }
});

// GET route to fetch all completed orders
app.get('/api/orderc', async (req, res) => {
  let connection;
  try {
      connection = await oracledb.getConnection(dbConfig);
      const result = await connection.execute(
          `SELECT * FROM COMPLETEORDERS_V`,
          [],
          {
              outFormat: oracledb.OUT_FORMAT_OBJECT // Ensure this is correct
          }
      );
      console.log("✅ Fetched Data:", result.rows);
      res.json(result.rows);
  } catch (err) {
      console.error("❌ Database query error:", err);
      res.status(500).json({ error: "Internal Server Error" });
  } finally {
      if (connection) await connection.close();
  }
});

app.post('/api/updateOrderStatus', async (req, res) => {
  const { orderId, newStatus } = req.body;

  if (!orderId || !newStatus) {
    return res.status(400).json({ error: 'Order ID and new status are required.' });
  }
  let connection;
  try {
    // Execute the PL/SQL function
    connection = await oracledb.getConnection(dbConfig);
    const result = await connection.execute(
      `BEGIN
         update_order_and_payment_status(
           p_order_id => :orderId,
           p_orderStatus => :newStatus
         );
       END;`,
      {
        orderId: { val: orderId, type: oracledb.NUMBER },
        newStatus: { val: newStatus, type: oracledb.STRING },
      },
      { autoCommit: true }
    );

    res.status(200).json({
      message: `Order status for Order ID ${orderId} updated to "${newStatus}".`,
      result: result,
    });
  } catch (err) {
    console.error('❌ Error executing PL/SQL function:', err);
    res.status(500).json({ error: 'Failed to update order status.' });
  }
});
app.get('/api/perfumegender', async (req, res) => {
  const { gender} = req.query;
  console.log(gender);

  try {
    const query = `
      SELECT * FROM PERFUMES_V
      WHERE LOWER(GENDERNAME) = LOWER(:gender)`;

    const binds = {
      gender: gender
    };

    const result = await connection.execute(query, binds, { outFormat: oracledb.OUT_FORMAT_OBJECT });
    res.json(result.rows);
  } catch (err) {
    console.error("❌ Error fetching filtered products:", err);
    res.status(500).json({ error: "Database query failed" });
  }
});

app.get('/api/perfumegenderFragrance', async (req, res) => {
  const { gender , fragrance} = req.query;
  console.log(gender);
  console.log(fragrance);

  try {
    const query = `
      SELECT * FROM PERFUMES_V
      WHERE LOWER(GENDERNAME) = LOWER(:gender)
      AND LOWER(CATEGORYNAME) = LOWER(:fragrance)`;

    const binds = {
      gender: gender,
      fragrance : fragrance
    };

    const result = await connection.execute(query, binds, { outFormat: oracledb.OUT_FORMAT_OBJECT });
    res.json(result.rows);
  } catch (err) {
    console.error("❌ Error fetching filtered products:", err);
    res.status(500).json({ error: "Database query failed" });
  }
});

app.get('/api/perfumefragrance', async (req, res) => {
  const { fragrance} = req.query;
  console.log(fragrance);

  try {
    const query = `
      SELECT * FROM PERFUMES_V
      WHERE LOWER(CATEGORYNAME) = LOWER(:fragrance)`;

    const binds = {
      fragrance: fragrance
    };

    const result = await connection.execute(query, binds, { outFormat: oracledb.OUT_FORMAT_OBJECT });
    res.json(result.rows);
  } catch (err) {
    console.error("❌ Error fetching filtered products:", err);
    res.status(500).json({ error: "Database query failed" });
  }
});

app.post('/api/customer/login', async (req, res) => {
  const { username, password } = req.body;

  try {
    const connection = await oracledb.getConnection(dbConfig);

    const result = await connection.execute(
      `SELECT * FROM CHECKLOGINCREDENTIALS WHERE Email = :username AND password = :password AND UserType = 'Customer'`,
      [username, password],
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
    console.log("✅ Fetched Data:", result.rows);
     if (result.rows.length > 0) {
      const userID = result.rows[0].USERID;
      console.log(userID);
      return res.status(200).json({
        success:true,
        message: 'Login successful',
        userId : userID
      });
    } else {
      return res.status(401).json({ message: 'Invalid credentials' });
    }
    await connection.close();
  } catch (err) {
    console.error('Customer Login Error:', err);
    res.status(500).json({ success: false, message: 'Internal server error' });
  }
});

// MANAGER LOGIN
app.post('/api/manager/login', async (req, res) => {
  const { managerId, username, password } = req.body;

  try {
    const connection = await oracledb.getConnection(dbConfig);

    const result = await connection.execute(
      `SELECT * FROM CHECKLOGINCREDENTIALS WHERE Email = :username AND Password = :password AND Userid = :managerId AND UserType = 'Manager'`,
      [username, password, managerId]
    );

    if (result.rows.length > 0) {
      res.json({ success: true, message: 'Manager login successful.' });
    } else {
      res.json({ success: false, message: 'Invalid credentials for manager.' });
    }

    await connection.close();
  } catch (err) {
    console.error('Manager Login Error:', err);
    res.status(500).json({ success: false, message: 'Internal server error' });
  }
});

// REGISTER
app.post('/api/register', async (req, res) => {
  const { username, password } = req.body;

  try {
    const connection = await oracledb.getConnection(dbConfig);

    // Check if user already exists
    const checkResult = await connection.execute(
      `SELECT * FROM CHECKLOGINCREDENTIALS WHERE Email = :username`,
      [username]
    );

    if (checkResult.rows.length > 0) {
      return res.json({ success: false, message: 'Username already exists.' });
    }

     await connection.execute(
      `BEGIN
      RegisterProcedure(:username, :password , 'Customer');
      END;`,
      [username, password],
      { autoCommit: true }
    );

    res.json({ success: true, message: 'Registration successful.' });

    await connection.close();
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

  let connection;

  try {
    connection = await oracledb.getConnection(dbConfig);

    const result = await connection.execute(
      `BEGIN
         PlacePerfumeOrder(
           :customerID,
           :perfumeID,
           :packagingTypeID,
           :orderedQuantity,
           :firstName,
           :lastName,
           :phoneNumber,
           :street,
           :mohallah,
           :city,
           :province
         );
       END;`,
      {
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
      },
      { autoCommit: true }
    );
    res.status(200).json({ message: 'Order placed successfully!' });

  } catch (err) {
    console.error('Error placing order:', err);
    res.status(500).json({ error: err.message });
  } finally {
    if (connection) {
      try {
        await connection.close();
      } catch (err) {
        console.error('Error closing connection:', err);
      }
    }
  }
});

// GET route to fetch orders for a specific customer based on CustomerID
app.get('/api/orders', async (req, res) => {
    const customerID = req.query.customerID; // Customer ID from query parameter

    if (!customerID) {
        return res.status(400).json({ error: 'CustomerID is required' });
    }

    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig); // Assuming dbConfig is set up
        const result = await connection.execute(
            `SELECT PerfumeName, PerfumeDescription, PerfumeImage, TotalPrice, OrderStatus , OrderId
             FROM CustomerPerfumesView
             WHERE CustomerID = :customerID`,
            [customerID],
            {
                outFormat: oracledb.OUT_FORMAT_OBJECT // Ensure the result format is object
            }
        );

        console.log("✅ Fetched Data for CustomerID:", customerID, result.rows);
        res.json(result.rows); // Send the fetched data as JSON response
    } catch (err) {
        console.error("❌ Database query error:", err);
        res.status(500).json({ error: "Internal Server Error" });
    } finally {
        if (connection) await connection.close(); // Close the DB connection
    }
});

app.get('/api/receipt', async (req, res) => {
    const orderID = req.query.orderID; // Order ID from query parameter

    if (!orderID) {
        return res.status(400).json({ error: 'OrderID is required' });
    }

    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig); // Assuming dbConfig is set up
        const result = await connection.execute(
            `SELECT * FROM ReceiptView WHERE OrderID = :orderID`,
            [orderID],
            {
                outFormat: oracledb.OUT_FORMAT_OBJECT // Ensure the result format is object
            }
        );

        console.log("✅ Fetched Receipt Data for OrderID:", orderID, result.rows);
        
        // Check if data was found
        if (result.rows.length === 0) {
            return res.status(404).json({ error: 'Receipt not found for this OrderID' });
        }

        res.json(result.rows[0]); // Send the fetched receipt data as JSON response
    } catch (err) {
        console.error("❌ Database query error:", err);
        res.status(500).json({ error: "Internal Server Error" });
    } finally {
        if (connection) await connection.close(); // Close the DB connection
    }
});

app.post('/api/update-price', async (req, res) => {
  const { perfumeId, updatedPrice } = req.body;

  if (!perfumeId || !updatedPrice) {
    return res.status(400).json({ error: "Missing perfume ID or updated price." });
  }

  let connection;
  try {
    connection = await oracledb.getConnection(dbConfig);
    await connection.execute(
      `BEGIN UpdatePrices(:id, :price); END;`,
      {
        id: perfumeId,
        price: updatedPrice
      }
    );
    await connection.commit();
    res.json({ message: "Price updated successfully" });
  } catch (err) {
    console.error("Error executing procedure:", err);
    res.status(500).json({ error: "Database error" });
  } finally {
    if (connection) await connection.close();
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

  let connection;

  try {
    connection = await oracledb.getConnection(dbConfig);

    await connection.execute(
      `BEGIN
         AddPerfume(
           P_Name => :name,
           P_Description => :description,
           P_Price => :price,
           P_Stock => :stock,
           P_ImagePath => :imagePath,
           F_ID => :fragranceId,
           G_ID => :genderId
         );
       END;`,
      {
        name,
        description,
        price,
        stock,
        imagePath,
        fragranceId,
        genderId
      },
      { autoCommit: true }
    );
    res.status(200).json({ success: true, message: 'Perfume added successfully.' });
  } catch (error) {
    console.error('❌ Error adding perfume:', error);
    res.status(500).json({ success: false, message: 'Database error.' });
  } finally {
    if (connection) {
      try {
        await connection.close();
      } catch (err) {
        console.error('Error closing connection:', err);
      }
    }
  }
});

// GET route to fetch all employees
app.get('/api/customers', async (req, res) => {
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);
        const result = await connection.execute(
            `SELECT * FROM CustomersView`,
            [],
            {
                outFormat: oracledb.OUT_FORMAT_OBJECT // Ensure this is correct
            }
        );
        console.log("✅ Fetched Data:", result.rows);
        res.json(result.rows);
    } catch (err) {
        console.error("❌ Database query error:", err);
        res.status(500).json({ error: "Internal Server Error" });
    } finally {
        if (connection) await connection.close();
    }
});

app.get('/api/dashboard', async (req, res) => {
  let connection;

  try {
    connection = await oracledb.getConnection(dbConfig);

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

      // Top 5 Selling Perfumes
      connection.execute(
        `SELECT PerfumeName, SUM(OrderedQuantity) AS UnitsSold , SUM(TotalPrice) AS TotalSales
        FROM SALESDASHBOARD
        GROUP BY PerfumeName
        ORDER BY SUM(TotalPrice) DESC
        FETCH NEXT 5 ROWS ONLY`
      ),

      // Total Revenue
      connection.execute(
        `SELECT SUM(TotalPrice) AS TotalRevenue
         FROM SALESDASHBOARD
         WHERE ORDERSTATUS IN ('Delivered')`
      ),

      // Top 5 Customers
      connection.execute(
        `SELECT CustomerName, City, SUM(TotalPrice) AS TotalSpent
         FROM SALESDASHBOARD
         GROUP BY CustomerName, City
         ORDER BY SUM(TotalPrice) DESC
         FETCH NEXT 5 ROWS ONLY`
      ),

      // Top 5 Cities
      connection.execute(
        `SELECT City, COUNT(OrderID) AS Orders, SUM(TotalPrice) AS TotalSpent
         FROM SALESDASHBOARD
         GROUP BY City
         ORDER BY Count(OrderID) DESC
         FETCH NEXT 5 ROWS ONLY`
      ),

      // Incompleted Orders
      connection.execute(
        `SELECT COUNT(*) AS TotalIncompletedOrders
         FROM SALESDASHBOARD
         WHERE ORDERSTATUS IN ('In Progress', 'Shipped')`
      ),

      // Completed Orders
      connection.execute(
        `SELECT COUNT(*) AS TotalCompletedOrders
         FROM SALESDASHBOARD
         WHERE ORDERSTATUS = 'Delivered'`
      ),

      // Total Orders
      connection.execute(
        `SELECT COUNT(*) AS TotalOrders
         FROM SALESDASHBOARD`
      ),

      // Cancelled Orders
      connection.execute(
        `SELECT COUNT(*) AS TotalCancelledOrders
         FROM SALESDASHBOARD
         WHERE ORDERSTATUS = 'Cancelled'`
      ),

      // Total Perfumes
      connection.execute(
        `SELECT COUNT(*) AS TotalPerfumes
         FROM PERFUME`
      ),

      // Average Order Value
      connection.execute(
        `SELECT ROUND(AVG(TotalPrice), 2) AS AvgOrderValue
         FROM SALESDASHBOARD
         WHERE ORDERSTATUS NOT IN ('Cancelled')`
      ),
      //lowstock
      connection.execute(
        `SELECT COUNT(*) AS LowStock
         FROM PERFUME
         WHERE PERFUMESTOCK <= 500`
      )

    ] );

    // Send combined JSON response
    res.json({
      topPerfumes: topPerfumes.rows,
      totalRevenue: totalRevenue.rows[0][0],
      topCustomers: topCustomers.rows,
      topCities: topCities.rows,
      incompletedOrders: incompletedOrders.rows[0][0],
      completedOrders: completedOrders.rows[0][0],
      totalOrders: totalOrders.rows[0][0],
      cancelledOrders: cancelledOrders.rows[0][0],
      totalPerfumes: totalPerfumes.rows[0][0],
      avgOrderValue: averageOrderValue.rows[0][0],
      lowStock: lowStock.rows[0][0]
    });

  } catch (err) {
    console.error("Error in /api/dashboard:", err);
    res.status(500).json({ error: "Database error" });
  } finally {
    if (connection) {
      try {
        await connection.close();
      } catch (err) {
        console.error("Error closing connection:", err);
      }
    }
  }
})

app.post('/api/inventory-update', async (req, res) => {
  const { perfumeId, managerId, changeLog, quantityChanged, remarks } = req.body;

  try {
    const connection = await oracledb.getConnection(dbConfig);

    const result = await connection.execute(
      `BEGIN
         InventoryChanges(:P_ID, :M_ID, :ChLog, :QtyChng, :Remarks);
       END;`,
      {
        P_ID: perfumeId,
        M_ID: managerId,
        ChLog: changeLog,
        QtyChng: quantityChanged,
        Remarks: remarks
      }
    );

    await connection.commit();
    await connection.close();

    res.status(200).json({ message: 'Inventory update successful!' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Error updating inventory', error: err.message });
  }
});


app.listen(PORT, () => console.log(`🚀 Server running at http://localhost:${PORT}`));
