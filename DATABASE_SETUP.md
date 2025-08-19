# 🗄️ Database Setup Guide for XAMPP

## Step 1: Install and Start XAMPP

1. **Download XAMPP** from https://www.apachefriends.org/
2. **Install XAMPP** on your system
3. **Start XAMPP Control Panel**
4. **Start Apache and MySQL** services

## Step 2: Access phpMyAdmin

1. Open your web browser
2. Go to: `http://localhost/phpmyadmin`
3. Login (default: no password for root user)

## Step 3: Create Database

### Option A: Using phpMyAdmin Interface
1. Click "New" in the left sidebar
2. Enter database name: `customer_management_db`
3. Choose collation: `utf8mb4_unicode_ci`
4. Click "Create"

### Option B: Using SQL (Recommended)
1. Click "SQL" tab in phpMyAdmin
2. Copy and paste the content from `database_setup.sql`
3. Click "Go" to execute

## Step 4: Insert Sample Data (Optional)

1. After creating the database structure, go to SQL tab
2. Copy and paste the content from `sample_data.sql`
3. Click "Go" to execute
4. Verify data insertion by checking the record counts

## Step 5: Configure Backend Connection

Update your `backend/.env` file:

```env
# Database Configuration for XAMPP
DB_HOST=localhost
DB_PORT=3306
DB_NAME=customer_management_db
DB_USER=root
DB_PASSWORD=

# If you set a password for MySQL root user:
# DB_PASSWORD=your_mysql_password
```

## Step 6: Test Database Connection

Run this test in backend directory:

```bash
cd backend
npm run migrate
```

If you see "Database connection established successfully", you're all set!

## 📋 Database Schema Overview

### Core Tables:
- **users** - System users (admin, staff, customer, delivery)
- **customers** - Customer profiles and details
- **products** - Product catalog and inventory
- **orders** - Customer orders
- **order_items** - Items within each order
- **deliveries** - Delivery tracking and management
- **inventories** - Stock movement history
- **inquiries** - Customer support tickets
- **notifications** - System notifications
- **qr_codes** - QR code management

### Sample Data Included:
- ✅ 6 Users (Admin, Staff, 2 Customers, 2 Delivery persons)
- ✅ 2 Customer profiles
- ✅ 10 Products with varying stock levels
- ✅ 3 Sample orders with different statuses
- ✅ Order items linking products to orders
- ✅ 2 Delivery records
- ✅ Stock movement history
- ✅ Sample inquiries and notifications

## 🔐 Default Login Credentials

| Role     | Email                          | Password |
|----------|--------------------------------|----------|
| Admin    | admin@customermanagement.com   | admin123 |
| Staff    | staff@customermanagement.com   | admin123 |
| Customer | john.doe@example.com           | admin123 |
| Customer | jane.smith@example.com         | admin123 |
| Delivery | delivery@customermanagement.com| admin123 |
| Delivery | mike.wilson@example.com        | admin123 |

## 🚨 Troubleshooting

### Common Issues:

1. **MySQL won't start in XAMPP**
   - Check if port 3306 is already in use
   - Try changing MySQL port in XAMPP config
   - Restart XAMPP as administrator

2. **Access denied for user 'root'**
   - Reset MySQL root password in XAMPP
   - Or create a new MySQL user with privileges

3. **Database connection fails**
   - Verify MySQL is running in XAMPP
   - Check database name spelling
   - Ensure backend/.env has correct credentials

4. **Foreign key constraint errors**
   - Run the SQL scripts in the correct order
   - First `database_setup.sql`, then `sample_data.sql`

### Verification Queries:

```sql
-- Check if all tables are created
SHOW TABLES;

-- Check user accounts
SELECT id, firstName, lastName, email, role FROM users;

-- Check products with low stock
SELECT name, sku, stock, minStockLevel 
FROM products 
WHERE stock <= minStockLevel;

-- Check recent orders
SELECT o.orderNumber, c.firstName, c.lastName, o.status, o.totalAmount 
FROM orders o 
JOIN customers c ON o.customerId = c.id 
ORDER BY o.createdAt DESC;
```

## 🎯 Next Steps After Database Setup

1. ✅ Database created and populated
2. 🔄 Update backend/.env file
3. 🚀 Start backend server: `cd backend && npm run dev`
4. 🎨 Start frontend server: `cd frontend && npm start`
5. 🌐 Access application at http://localhost:3000

## 📞 Support

If you encounter any issues:
1. Check XAMPP logs in the XAMPP installation directory
2. Verify MySQL service is running
3. Test database connection using phpMyAdmin
4. Check backend logs for detailed error messages
