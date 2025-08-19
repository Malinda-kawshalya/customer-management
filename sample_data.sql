-- Sample Data for Customer Management System
-- Run this after creating the database structure

USE customer_management_db;

-- ============================================================
-- INSERT SAMPLE USERS
-- ============================================================
-- Password: admin123 (hashed with bcrypt)
INSERT INTO users (firstName, lastName, email, password, phone, role, status, emailVerifiedAt) VALUES
('Admin', 'User', 'admin@customermanagement.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewHkKIsZQl2MKvPS', '1234567890', 'admin', 'active', NOW()),
('Staff', 'Member', 'staff@customermanagement.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewHkKIsZQl2MKvPS', '1234567891', 'staff', 'active', NOW()),
('John', 'Doe', 'john.doe@example.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewHkKIsZQl2MKvPS', '1234567892', 'customer', 'active', NOW()),
('Jane', 'Smith', 'jane.smith@example.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewHkKIsZQl2MKvPS', '1234567893', 'customer', 'active', NOW()),
('Delivery', 'Person', 'delivery@customermanagement.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewHkKIsZQl2MKvPS', '1234567894', 'delivery', 'active', NOW()),
('Mike', 'Wilson', 'mike.wilson@example.com', 'delivery', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewHkKIsZQl2MKvPS', '1234567895', 'delivery', 'active', NOW());

-- ============================================================
-- INSERT SAMPLE CUSTOMERS
-- ============================================================
INSERT INTO customers (userId, firstName, lastName, email, phone, dateOfBirth, address, emergencyContact, loyaltyPoints) VALUES
(3, 'John', 'Doe', 'john.doe@example.com', '1234567892', '1990-01-15', 
 '{"street": "123 Main St", "city": "Anytown", "state": "CA", "zipCode": "12345", "country": "USA"}',
 '{"name": "Jane Doe", "phone": "1234567899", "relationship": "Spouse"}', 100),
(4, 'Jane', 'Smith', 'jane.smith@example.com', '1234567893', '1985-05-20',
 '{"street": "456 Oak Ave", "city": "Springfield", "state": "NY", "zipCode": "67890", "country": "USA"}',
 '{"name": "Bob Smith", "phone": "1234567898", "relationship": "Brother"}', 250);

-- ============================================================
-- INSERT SAMPLE PRODUCTS
-- ============================================================
INSERT INTO products (name, description, sku, category, price, stock, minStockLevel, maxStockLevel, unit) VALUES
('Laptop Computer', 'High-performance laptop for business and gaming', 'LAPTOP001', 'Electronics', 999.99, 50, 10, 100, 'piece'),
('Wireless Mouse', 'Ergonomic wireless mouse with precision tracking', 'MOUSE001', 'Electronics', 29.99, 200, 50, 500, 'piece'),
('Mechanical Keyboard', 'RGB mechanical keyboard with blue switches', 'KEYBOARD001', 'Electronics', 89.99, 75, 25, 150, 'piece'),
('Office Chair', 'Comfortable ergonomic office chair', 'CHAIR001', 'Furniture', 199.99, 25, 5, 50, 'piece'),
('Desk Lamp', 'LED desk lamp with adjustable brightness', 'LAMP001', 'Furniture', 49.99, 75, 15, 150, 'piece'),
('Water Bottle', 'Stainless steel water bottle 500ml', 'BOTTLE001', 'Accessories', 19.99, 5, 20, 200, 'piece'),
('Phone Case', 'Protective phone case for iPhone', 'CASE001', 'Accessories', 24.99, 150, 30, 300, 'piece'),
('USB Cable', 'USB-C to USB-A cable 2 meters', 'CABLE001', 'Electronics', 12.99, 300, 100, 500, 'piece'),
('Notebook', 'Spiral-bound notebook A4 size', 'BOOK001', 'Stationery', 4.99, 500, 100, 1000, 'piece'),
('Pen Set', 'Set of 5 ballpoint pens', 'PEN001', 'Stationery', 9.99, 200, 50, 400, 'set');

-- ============================================================
-- INSERT SAMPLE ORDERS
-- ============================================================
INSERT INTO orders (orderNumber, customerId, totalAmount, status, shippingAddress, notes) VALUES
('ORD202508190001', 1, 1019.98, 'delivered', 
 '{"street": "123 Main St", "city": "Anytown", "state": "CA", "zipCode": "12345", "country": "USA"}',
 'Please deliver to front door'),
('ORD202508190002', 2, 89.99, 'in_progress',
 '{"street": "456 Oak Ave", "city": "Springfield", "state": "NY", "zipCode": "67890", "country": "USA"}',
 'Call before delivery'),
('ORD202508190003', 1, 49.98, 'pending',
 '{"street": "123 Main St", "city": "Anytown", "state": "CA", "zipCode": "12345", "country": "USA"}',
 'Leave at reception');

-- ============================================================
-- INSERT SAMPLE ORDER ITEMS
-- ============================================================
INSERT INTO order_items (orderId, productId, quantity, unitPrice, totalPrice) VALUES
-- Order 1 items
(1, 1, 1, 999.99, 999.99),  -- Laptop
(1, 2, 1, 29.99, 29.99),    -- Mouse
-- Order 2 items  
(2, 3, 1, 89.99, 89.99),    -- Keyboard
-- Order 3 items
(3, 6, 1, 19.99, 19.99),    -- Water Bottle
(3, 2, 1, 29.99, 29.99);    -- Mouse

-- ============================================================
-- INSERT SAMPLE DELIVERIES
-- ============================================================
INSERT INTO deliveries (orderId, deliveryPersonId, trackingNumber, status, scheduledDate, estimatedDelivery, deliveryAddress, recipientName, priority) VALUES
(1, 5, 'TRK202508190001', 'delivered', '2025-08-18 14:00:00', '2025-08-18 16:00:00',
 '{"street": "123 Main St", "city": "Anytown", "state": "CA", "zipCode": "12345", "country": "USA"}',
 'John Doe', 'normal'),
(2, 6, 'TRK202508190002', 'in_transit', '2025-08-19 10:00:00', '2025-08-19 15:00:00',
 '{"street": "456 Oak Ave", "city": "Springfield", "state": "NY", "zipCode": "67890", "country": "USA"}',
 'Jane Smith', 'high');

-- ============================================================
-- INSERT SAMPLE INVENTORY MOVEMENTS
-- ============================================================
INSERT INTO inventories (productId, type, quantity, previousStock, newStock, reason, userId) VALUES
(6, 'subtract', 15, 20, 5, 'Sales order fulfillment', 2),
(1, 'add', 25, 25, 50, 'New stock received', 2),
(2, 'subtract', 2, 202, 200, 'Order fulfillment', 2);

-- ============================================================
-- INSERT SAMPLE INQUIRIES
-- ============================================================
INSERT INTO inquiries (customerId, orderId, subject, message, type, status, priority) VALUES
(1, 1, 'Delivery Confirmation', 'I received my laptop order. Thank you for the fast delivery!', 'delivery', 'resolved', 'low'),
(2, 2, 'Order Status Update', 'Can you please provide an update on my keyboard order?', 'order', 'in_progress', 'medium'),
(1, NULL, 'Product Inquiry', 'Do you have any gaming mice available?', 'product', 'open', 'low');

-- ============================================================
-- INSERT SAMPLE NOTIFICATIONS
-- ============================================================
INSERT INTO notifications (userId, title, message, type, category) VALUES
(3, 'Order Delivered', 'Your order ORD202508190001 has been delivered successfully.', 'success', 'delivery'),
(4, 'Order In Transit', 'Your order ORD202508190002 is now in transit.', 'info', 'delivery'),
(2, 'Low Stock Alert', 'Product "Water Bottle" is running low on stock (5 remaining).', 'warning', 'inventory'),
(1, 'System Maintenance', 'Scheduled maintenance will occur tonight at 2 AM.', 'info', 'system');

-- ============================================================
-- VERIFY DATA INSERTION
-- ============================================================
-- Check record counts
SELECT 
    'users' as table_name, COUNT(*) as record_count FROM users
UNION ALL
SELECT 'customers', COUNT(*) FROM customers  
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'deliveries', COUNT(*) FROM deliveries
UNION ALL
SELECT 'inventories', COUNT(*) FROM inventories
UNION ALL
SELECT 'inquiries', COUNT(*) FROM inquiries
UNION ALL
SELECT 'notifications', COUNT(*) FROM notifications;
