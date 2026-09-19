# 🧴 Perfume Store

A full-stack **Perfume E-Commerce & Inventory Management System** built with **HTML, CSS, and vanilla JavaScript** on the frontend, a **Node.js + Express** backend, and an **Oracle Database** for persistent storage. The system supports both a **customer-facing storefront** (browse, filter, and order perfumes) and a **manager/admin dashboard** (inventory, orders, customers, and sales analytics).

---

## 📖 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Database Schema](#-database-schema)
- [API Endpoints](#-api-endpoints)
- [Getting Started](#-getting-started)
- [Configuration](#-configuration)
- [Usage](#-usage)
- [Roadmap](#-roadmap)
- [Author](#-author)
- [License](#-license)

---

## 🌸 Overview

**Perfume Store** is a database-driven web application for a fragrance retail business. It was built as a complete order-to-delivery system covering:

- A **customer storefront** where users can register/log in, browse perfumes by gender and fragrance category, place orders, and view digital receipts.
- A **manager dashboard** for adding/updating perfumes and stock, managing orders (completed/incomplete), viewing customers, and tracking real-time sales analytics.

All business logic — pricing updates, inventory changes, order status transitions — is handled through **PL/SQL stored procedures, triggers, and views** in Oracle, called from a thin Express API layer.

---

## ✨ Features

### 🛍️ Customer-Facing
- User registration & login (customer/manager roles)
- Browse perfumes filtered by **gender** (Men/Women) and **fragrance category**
- Product catalog with images, descriptions, pricing, and stock status
- Order placement flow (`Order-Form`) with generated receipts
- Order history lookup by Order ID

### 🛠️ Admin / Manager Dashboard
- **Dashboard** with live analytics: total revenue, total/average order value, completed vs. incomplete vs. cancelled orders, low-stock alerts
- **Top 5 selling perfumes**, **top 5 customers**, and **top 5 cities by sales**
- **Add Perfume** — create new products with images, pricing, gender, and fragrance mapping
- **Update Perfume / Add Stock** — adjust price and stock via stored procedures, with inventory change logs
- **Order management** — view and update order/payment status for both completed and in-progress orders
- **Customer management** — view all registered customers

### 🗄️ Database-Driven Design
- Normalized relational schema (perfumes, fragrance categories, gender mapping, packaging, users, customers, managers, inventory, orders)
- PL/SQL **procedures** for adding perfumes, updating prices, logging inventory changes, and updating order/payment status
- **Triggers** and **sequences** for automatic ID generation and data integrity
- **Views** (e.g. `PERFUME_V`, `PERFUMES_V`, `SALESDASHBOARD`, `INCOMPLETEORDERS_V`, `COMPLETEORDERS_V`, `CustomersView`) that power the dashboard and storefront queries

---

## 🧰 Tech Stack

| Layer          | Technology                                   |
|----------------|-----------------------------------------------|
| Frontend       | HTML5, CSS3, Vanilla JavaScript              |
| Backend        | Node.js, Express 5                           |
| Database       | Oracle Database (PL/SQL: tables, views, procedures, triggers, sequences) |
| DB Driver      | `oracledb` (Node.js Oracle driver)           |
| Middleware     | `cors`, `body-parser`                        |
| Tooling        | VS Code (`.vscode` workspace config)         |

---

## 📁 Project Structure

```
Perfume-Store/
├── CSS/
│   ├── Style.css              # Global storefront styling
│   ├── DashboardStyle.css      # Admin dashboard styling
│   ├── SidebarStyle.css        # Admin sidebar navigation
│   ├── OrderFormStyle.css      # Order form styling
│   ├── ViewPerfumes.css        # Product listing/grid styling
│   └── loginStyle.css          # Login/Signup page styling
│
├── HTML/
│   ├── LoginSignup.html         # Customer/Manager auth
│   ├── View Perfumes.html       # Storefront product catalog
│   ├── Order-Form.html          # Checkout / order placement
│   ├── Admin.html               # Admin entry point
│   ├── Dashboard.html           # Sales & analytics dashboard
│   ├── Sidebar.html             # Shared admin sidebar
│   ├── Add Perfume.html         # Add new product
│   ├── Add Stock.html           # Restock / update stock & price
│   ├── Update perfume.html      # Edit existing product
│   ├── Customers.html           # Customer list (admin)
│   ├── CustomerOrders.html      # Per-customer order view
│   ├── Completed Orders.html    # Fulfilled orders
│   ├── Incompleted Orders.html  # Pending/in-progress orders
│   └── J..html
│
├── javascript/
│   ├── script.js                        # Storefront logic (product rendering, filters)
│   ├── API.js                           # Shared API/fetch helper functions
│   ├── Login-SIgnup-Register.js         # Auth handling
│   ├── ViewPerfume.js                   # Product listing logic
│   ├── AddPerfume.js                    # Add-product form logic
│   ├── Dashbaord.js                     # Dashboard charts/stats rendering
│   ├── Customers.js                     # Customer list rendering
│   ├── CustomerOrders.js                # Customer order history rendering
│   ├── Completed Orders.js              # Completed orders table logic
│   └── View Incompleted Orders.js       # Incomplete orders table logic
│
├── server/
│   ├── Server.js                # Express app & all REST API routes
│   ├── package.json             # Backend dependencies & scripts
│   └── package-lock.json
│
├── SQL Worksheets/
│   ├── PERFUME STORE DATABASE TABLES.sql       # Schema (DDL)
│   ├── PERFUME STORE DATABASE INSERTION.sql    # Seed data
│   ├── PERFUME STORE DATABASE VIEWS.sql        # Reporting/query views
│   ├── PERFUME STORE DATABASE PROCEDURES.sql   # Stored procedures
│   ├── PERFUME STORE DATABASE TRIGGERS.sql     # Triggers
│   ├── PERFUME STORE DATABASE SEQUENCE.sql     # ID sequences
│   └── PERFUME STORE DATABASE QUERIES.sql      # Ad-hoc/reporting queries
│
├── Images/
│   ├── MENS/                    # Men's perfume product images
│   ├── WOMEN/                   # Women's perfume product images
│   └── SZ LOGO.png              # Brand logo
│
├── BG.jpeg                      # Background/hero image
└── .vscode/                     # Editor workspace settings
```

---

## 🗃️ Database Schema

The Oracle schema (see `SQL Worksheets/`) models the store around these core entities:

- **Perfume** — product catalog (name, price, stock, description, image)
- **FragranceCategory** — scent categories (intensity, oil concentration, longevity, occasions)
- **GenderCategory** — Men / Women product classification
- **PerfumeFragranceMap** / **PerfumeGenderMap** — many-to-many mapping tables
- **PackagingType** / **Feature** / **PackagingFeatureMap** — packaging options and included features
- **PerfumeStoreUsers** — shared login table for customers & managers (`UserType` = Customer/Manager)
- **PerfumeStoreCustomers** — customer address details (linked to Users)
- **PerfumeStoreManagers** — manager details (CNIC, role, hire date)
- **PerfumeInventory** — inventory change log (restocks, adjustments, remarks)
- **Orders / Order Items / Payments** — order lifecycle and payment status (queried via `SALESDASHBOARD`, `INCOMPLETEORDERS_V`, `COMPLETEORDERS_V`)

Reporting views such as `PERFUME_V`, `PERFUMES_V`, `SALESDASHBOARD`, and `CustomersView` denormalize this data for fast reads on the storefront and dashboard.

Business rules are enforced through **PL/SQL procedures** including:
- `AddPerfume(...)` — insert a new perfume with gender/fragrance mapping
- `UpdatePrices(id, price)` — update a perfume's price
- `InventoryChanges(...)` — log stock adjustments per manager
- `update_order_and_payment_status(order_id, status)` — synchronize order & payment status

---

## 🔌 API Endpoints

All endpoints are served from `server/Server.js` on `http://localhost:3000`.

| Method | Endpoint                          | Description                                             |
|--------|------------------------------------|-----------------------------------------------------------|
| GET    | `/api/products`                    | Fetch all products (`Perfumes_Display` view)              |
| GET    | `/api/perfumes`                    | Fetch all perfumes (`PERFUME_V`, ordered by ID)            |
| GET    | `/api/perfumegender?gender=`       | Filter perfumes by gender                                  |
| GET    | `/api/perfumefragrance?fragrance=` | Filter perfumes by fragrance category                      |
| GET    | `/api/perfumegenderFragrance?gender=&fragrance=` | Filter perfumes by both gender & fragrance    |
| POST   | `/api/customer/login`              | Customer authentication                                    |
| POST   | `/api/manager/login`               | Manager authentication (requires Manager ID)                |
| POST   | `/api/register`                    | New user registration                                       |
| POST   | `/place-order`                     | Place a new customer order                                  |
| GET    | `/api/orders`                      | Fetch order details                                         |
| GET    | `/api/orderin`                     | Fetch incomplete/in-progress orders (`INCOMPLETEORDERS_V`)   |
| GET    | `/api/orderc`                      | Fetch completed orders (`COMPLETEORDERS_V`)                  |
| POST   | `/api/updateOrderStatus`           | Update order & payment status (calls stored procedure)      |
| GET    | `/api/receipt?orderId=`           | Fetch receipt details for an order                           |
| POST   | `/add-perfume`                     | Add a new perfume product                                    |
| POST   | `/api/update-price`                | Update a perfume's price (calls `UpdatePrices` procedure)     |
| POST   | `/api/inventory-update`            | Log an inventory/stock change (calls `InventoryChanges`)      |
| GET    | `/api/customers`                   | Fetch all customers (`CustomersView`)                         |
| GET    | `/api/dashboard`                   | Aggregated sales dashboard data (revenue, top sellers, KPIs) |

> Static frontend files (`HTML/`, `Images/`) are also served directly by the Express app.

---

## 🚀 Getting Started

### Prerequisites
- [Node.js](https://nodejs.org/) (v18+ recommended)
- Oracle Database (e.g. Oracle XE) running locally or accessible remotely
- Oracle Instant Client configured for the `oracledb` Node driver

### 1. Clone the repository
```bash
git clone https://github.com/muhammad-sajid17/Perfume-Store.git
cd Perfume-Store
```

### 2. Set up the database
Run the SQL scripts in `SQL Worksheets/` against your Oracle instance, **in this order**:
```
PERFUME STORE DATABASE SEQUENCE.sql
PERFUME STORE DATABASE TABLES.sql
PERFUME STORE DATABASE TRIGGERS.sql
PERFUME STORE DATABASE PROCEDURES.sql
PERFUME STORE DATABASE VIEWS.sql
PERFUME STORE DATABASE INSERTION.sql   -- optional seed data
```

### 3. Install backend dependencies
```bash
cd server
npm install
```

### 4. Configure the database connection
Update the `dbConfig` object in `server/Server.js` with your own Oracle credentials (see [Configuration](#-configuration) below).

### 5. Run the server
```bash
npm start
```
The app will be available at **http://localhost:3000**.

---

## ⚙️ Configuration

Database credentials are currently defined inline in `server/Server.js`:

```js
const dbConfig = {
    user: "your_db_user",
    password: "your_db_password",
    connectString: "localhost/orcl"
};
```

**Recommended improvement:** move these values into environment variables (e.g. using a `.env` file with the `dotenv` package) instead of hardcoding credentials in source control:

```js
const dbConfig = {
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    connectString: process.env.DB_CONNECT_STRING
};
```

---

## 🖥️ Usage

- **Customers:** open `HTML/LoginSignup.html` to register or log in, then browse `View Perfumes.html` to filter by gender/fragrance and place an order via `Order-Form.html`.
- **Managers/Admins:** log in via the manager flow and use `Dashboard.html` for sales KPIs, `Add Perfume.html` / `Update perfume.html` / `Add Stock.html` for catalog and inventory management, and the order pages to track fulfillment.

---

## 🗺️ Roadmap

- [ ] Move DB credentials to environment variables / a config file
- [ ] Add authentication tokens / session management (JWT)
- [ ] Add a proper `.env.example` and setup script
- [ ] Add unit/integration tests for API routes
- [ ] Migrate stored procedure logic documentation into this README or a `/docs` folder
- [ ] Add pagination and search to the product catalog

---

## 👤 Author

**Muhammad Sajid**
- GitHub: [@muhammad-sajid17](https://github.com/muhammad-sajid17)

---

## 📄 License

No license has been specified for this repository yet. Consider adding one (e.g. MIT) to clarify how others may use this project.
