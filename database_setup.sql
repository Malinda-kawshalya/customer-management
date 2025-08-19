-- Customer Management System Database Setup
-- For use with XAMPP/MySQL

-- Create the database
CREATE DATABASE IF NOT EXISTS customer_management_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Use the database
USE customer_management_db;

-- ============================================================
-- 1. USERS TABLE
-- ============================================================
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    role ENUM('admin', 'staff', 'customer', 'delivery') NOT NULL DEFAULT 'customer',
    status ENUM('active', 'inactive', 'suspended', 'pending') NOT NULL DEFAULT 'active',
    lastLogin DATETIME,
    emailVerifiedAt DATETIME,
    profileImage VARCHAR(500),
    resetPasswordToken VARCHAR(255),
    resetPasswordExpires DATETIME,
    address JSON,
    preferences JSON,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_users_email (email),
    INDEX idx_users_role (role),
    INDEX idx_users_status (status)
);

-- ============================================================
-- 2. CUSTOMERS TABLE
-- ============================================================
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userId INT NOT NULL,
    firstName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    dateOfBirth DATE,
    address JSON NOT NULL,
    emergencyContact JSON,
    status ENUM('active', 'inactive', 'suspended', 'pending') NOT NULL DEFAULT 'active',
    loyaltyPoints INT NOT NULL DEFAULT 0,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    INDEX idx_customers_userId (userId),
    INDEX idx_customers_email (email),
    INDEX idx_customers_status (status)
);

-- ============================================================
-- 3. PRODUCTS TABLE
-- ============================================================
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    sku VARCHAR(100) NOT NULL UNIQUE,
    category VARCHAR(100),
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    minStockLevel INT NOT NULL DEFAULT 10,
    maxStockLevel INT,
    unit VARCHAR(50) DEFAULT 'piece',
    status ENUM('active', 'inactive', 'discontinued') NOT NULL DEFAULT 'active',
    images JSON,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_products_sku (sku),
    INDEX idx_products_category (category),
    INDEX idx_products_status (status),
    INDEX idx_products_stock (stock)
);

-- ============================================================
-- 4. ORDERS TABLE
-- ============================================================
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    orderNumber VARCHAR(100) NOT NULL UNIQUE,
    customerId INT NOT NULL,
    totalAmount DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'preparing', 'ready', 'out_for_delivery', 'delivered', 'cancelled', 'returned') NOT NULL DEFAULT 'pending',
    shippingAddress JSON NOT NULL,
    notes TEXT,
    cancelledAt DATETIME,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (customerId) REFERENCES customers(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX idx_orders_customerId (customerId),
    INDEX idx_orders_orderNumber (orderNumber),
    INDEX idx_orders_status (status),
    INDEX idx_orders_createdAt (createdAt)
);

-- ============================================================
-- 5. ORDER ITEMS TABLE
-- ============================================================
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    orderId INT NOT NULL,
    productId INT NOT NULL,
    quantity INT NOT NULL,
    unitPrice DECIMAL(10, 2) NOT NULL,
    totalPrice DECIMAL(10, 2) NOT NULL,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (orderId) REFERENCES orders(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (productId) REFERENCES products(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX idx_order_items_orderId (orderId),
    INDEX idx_order_items_productId (productId)
);

-- ============================================================
-- 6. DELIVERIES TABLE
-- ============================================================
CREATE TABLE deliveries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    orderId INT NOT NULL,
    deliveryPersonId INT,
    trackingNumber VARCHAR(100) NOT NULL UNIQUE,
    status ENUM('pending', 'assigned', 'picked_up', 'in_transit', 'delivered', 'failed', 'returned') NOT NULL DEFAULT 'pending',
    scheduledDate DATETIME,
    estimatedDelivery DATETIME,
    dispatchedAt DATETIME,
    actualDeliveryDate DATETIME,
    deliveryAddress JSON NOT NULL,
    recipientName VARCHAR(255),
    notes TEXT,
    priority ENUM('low', 'normal', 'high', 'urgent') NOT NULL DEFAULT 'normal',
    proof JSON,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (orderId) REFERENCES orders(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (deliveryPersonId) REFERENCES users(id) ON DELETE SET NULL ON UPDATE CASCADE,
    INDEX idx_deliveries_orderId (orderId),
    INDEX idx_deliveries_deliveryPersonId (deliveryPersonId),
    INDEX idx_deliveries_trackingNumber (trackingNumber),
    INDEX idx_deliveries_status (status),
    INDEX idx_deliveries_scheduledDate (scheduledDate)
);

-- ============================================================
-- 7. INVENTORIES TABLE (Stock Movements)
-- ============================================================
CREATE TABLE inventories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    productId INT NOT NULL,
    type ENUM('add', 'subtract', 'adjustment') NOT NULL,
    quantity INT NOT NULL,
    previousStock INT NOT NULL,
    newStock INT NOT NULL,
    reason VARCHAR(255),
    userId INT NOT NULL,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (productId) REFERENCES products(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (userId) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX idx_inventories_productId (productId),
    INDEX idx_inventories_userId (userId),
    INDEX idx_inventories_type (type),
    INDEX idx_inventories_createdAt (createdAt)
);

-- ============================================================
-- 8. INQUIRIES TABLE
-- ============================================================
CREATE TABLE inquiries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customerId INT NOT NULL,
    orderId INT,
    subject VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    type ENUM('general', 'order', 'delivery', 'product', 'complaint', 'feedback') NOT NULL DEFAULT 'general',
    status ENUM('open', 'in_progress', 'resolved', 'closed') NOT NULL DEFAULT 'open',
    priority ENUM('low', 'medium', 'high', 'urgent') NOT NULL DEFAULT 'medium',
    assignedTo INT,
    attachments JSON,
    resolution TEXT,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (customerId) REFERENCES customers(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (orderId) REFERENCES orders(id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (assignedTo) REFERENCES users(id) ON DELETE SET NULL ON UPDATE CASCADE,
    INDEX idx_inquiries_customerId (customerId),
    INDEX idx_inquiries_orderId (orderId),
    INDEX idx_inquiries_status (status),
    INDEX idx_inquiries_assignedTo (assignedTo)
);

-- ============================================================
-- 9. NOTIFICATIONS TABLE
-- ============================================================
CREATE TABLE notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userId INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    type ENUM('info', 'success', 'warning', 'error') NOT NULL DEFAULT 'info',
    category ENUM('order', 'delivery', 'inventory', 'system', 'promotion') NOT NULL DEFAULT 'system',
    isRead BOOLEAN NOT NULL DEFAULT FALSE,
    metadata JSON,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    INDEX idx_notifications_userId (userId),
    INDEX idx_notifications_isRead (isRead),
    INDEX idx_notifications_type (type),
    INDEX idx_notifications_createdAt (createdAt)
);

-- ============================================================
-- 10. QR_CODES TABLE
-- ============================================================
CREATE TABLE qr_codes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    entityType ENUM('order', 'product', 'delivery', 'customer') NOT NULL,
    entityId INT NOT NULL,
    qrData TEXT NOT NULL,
    qrImage VARCHAR(500),
    isActive BOOLEAN NOT NULL DEFAULT TRUE,
    createdBy INT NOT NULL,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (createdBy) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX idx_qr_codes_entityType (entityType),
    INDEX idx_qr_codes_entityId (entityId),
    INDEX idx_qr_codes_isActive (isActive),
    UNIQUE KEY unique_entity (entityType, entityId)
);
