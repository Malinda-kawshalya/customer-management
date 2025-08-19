# Customer Management System

A comprehensive customer, inventory, and delivery management system built with Node.js, Express, React, and MySQL.

## 🎯 Features

### Backend Features
- **Authentication & Authorization**: JWT-based auth with role-based access control (Admin, Staff, Customer, Delivery)
- **Customer Management**: Complete CRUD operations for customer profiles
- **Inventory Management**: Product catalog, stock management, low-stock alerts
- **Order Management**: Order creation, tracking, status updates
- **Delivery Management**: Delivery assignment, tracking, and status updates
- **QR Code Generation**: For products, orders, and deliveries
- **File Upload**: Profile pictures, product images, delivery proof
- **Email Notifications**: Order confirmations, delivery updates
- **API Documentation**: Comprehensive REST API with proper error handling

### Frontend Features
- **Responsive Design**: Bootstrap-based UI that works on all devices
- **Dashboard**: Role-specific dashboards (Admin, Staff, Customer, Delivery)
- **Customer Portal**: Order history, profile management, support
- **Admin Panel**: Complete system management and analytics
- **Inventory Management**: Stock tracking, product management
- **Delivery Tracking**: Real-time delivery status and tracking
- **QR Code Scanner**: For quick product/order lookup
- **Real-time Notifications**: Using React Context API

## 🚀 Getting Started

### Prerequisites
- Node.js (v14 or higher)
- MySQL (v5.7 or higher)
- npm or yarn

### Quick Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd customer-management-system
   ```

2. **Run the setup script**
   
   **Windows:**
   ```cmd
   setup.bat
   ```
   
   **Linux/Mac:**
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

3. **Configure Database**
   - Create a MySQL database named `customer_management_db`
   - Update `backend/.env` with your database credentials

4. **Start the Application**
   
   **Backend (Terminal 1):**
   ```bash
   cd backend
   npm run dev
   ```
   
   **Frontend (Terminal 2):**
   ```bash
   cd frontend
   npm start
   ```

5. **Access the Application**
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:5000
   - API Documentation: http://localhost:5000/api/v1/docs

### Default Login Credentials

| Role     | Email                          | Password |
|----------|--------------------------------|----------|
| Admin    | admin@customermanagement.com   | admin123 |
| Staff    | staff@customermanagement.com   | admin123 |
| Customer | john.doe@example.com           | admin123 |
| Delivery | delivery@customermanagement.com| admin123 |

## 📁 Project Structure

```
customer-management-system/
├── backend/
│   ├── config/           # Database and auth configuration
│   ├── controllers/      # Request handlers
│   ├── middleware/       # Auth, validation, error handling
│   ├── migrations/       # Database migrations
│   ├── models/          # Sequelize models
│   ├── routes/          # API routes
│   ├── seeders/         # Database seeders
│   ├── services/        # Business logic
│   ├── utils/           # Helper functions and constants
│   └── uploads/         # File uploads
├── frontend/
│   ├── public/          # Static files
│   ├── src/
│   │   ├── components/  # React components
│   │   ├── context/     # React Context providers
│   │   ├── hooks/       # Custom React hooks
│   │   ├── pages/       # Page components
│   │   ├── services/    # API services
│   │   ├── styles/      # CSS styles
│   │   └── utils/       # Helper functions
│   └── package.json
└── README.md
```

## 🔧 Manual Setup

If you prefer to set up manually:

### Backend Setup

1. **Install dependencies**
   ```bash
   cd backend
   npm install
   ```

2. **Environment Configuration**
   ```bash
   cp .env.example .env
   ```
   
   Update the `.env` file with your configuration:
   ```env
   NODE_ENV=development
   PORT=5000
   
   # Database Configuration
   DB_HOST=localhost
   DB_PORT=3306
   DB_NAME=customer_management_db
   DB_USER=your_db_user
   DB_PASSWORD=your_db_password
   
   # JWT Configuration
   JWT_SECRET=your_super_secret_jwt_key
   JWT_EXPIRE=7d
   JWT_REFRESH_SECRET=your_refresh_token_secret
   JWT_REFRESH_EXPIRE=30d
   
   # Email Configuration (optional)
   SMTP_HOST=smtp.gmail.com
   SMTP_PORT=587
   SMTP_USER=your_email@gmail.com
   SMTP_PASSWORD=your_app_password
   ```

3. **Database Setup**
   ```bash
   # Run migrations
   npm run migrate
   
   # Run seeders (optional - adds demo data)
   npm run seed
   ```

4. **Start Development Server**
   ```bash
   npm run dev
   ```

### Frontend Setup

1. **Install dependencies**
   ```bash
   cd frontend
   npm install
   ```

2. **Start Development Server**
   ```bash
   npm start
   ```

## 📚 API Documentation

### Authentication Endpoints
- `POST /api/v1/auth/register` - Register new user
- `POST /api/v1/auth/login` - User login
- `POST /api/v1/auth/logout` - User logout
- `GET /api/v1/auth/me` - Get current user profile
- `PUT /api/v1/auth/profile` - Update user profile

### Customer Endpoints
- `GET /api/v1/customers` - Get all customers (Admin/Staff)
- `GET /api/v1/customers/:id` - Get customer by ID
- `POST /api/v1/customers` - Create new customer
- `PUT /api/v1/customers/:id` - Update customer
- `DELETE /api/v1/customers/:id` - Delete customer

### Inventory Endpoints
- `GET /api/v1/inventory/products` - Get all products
- `POST /api/v1/inventory/products` - Create product
- `GET /api/v1/inventory/products/:id` - Get product by ID
- `PUT /api/v1/inventory/products/:id` - Update product
- `PUT /api/v1/inventory/products/:id/stock` - Update stock
- `GET /api/v1/inventory/movements` - Get inventory movements
- `GET /api/v1/inventory/stats` - Get inventory statistics

### Order Endpoints
- `GET /api/v1/orders` - Get all orders (Admin/Staff)
- `GET /api/v1/orders/my-orders` - Get customer's orders
- `POST /api/v1/orders` - Create new order
- `GET /api/v1/orders/:id` - Get order by ID
- `PUT /api/v1/orders/:id/status` - Update order status
- `PUT /api/v1/orders/:id/cancel` - Cancel order

### Delivery Endpoints
- `GET /api/v1/delivery` - Get all deliveries
- `GET /api/v1/delivery/my-deliveries` - Get assigned deliveries
- `POST /api/v1/delivery` - Create delivery
- `GET /api/v1/delivery/:id` - Get delivery by ID
- `PUT /api/v1/delivery/:id/status` - Update delivery status
- `GET /api/v1/delivery/track/:trackingNumber` - Track delivery

## 🛠️ Available Scripts

### Backend Scripts
- `npm start` - Start production server
- `npm run dev` - Start development server with nodemon
- `npm test` - Run tests
- `npm run migrate` - Run database migrations
- `npm run seed` - Run database seeders
- `npm run lint` - Run ESLint

### Frontend Scripts
- `npm start` - Start development server
- `npm run build` - Build for production
- `npm test` - Run tests
- `npm run eject` - Eject from Create React App

## 🔒 Security Features

- JWT authentication with refresh tokens
- Password hashing using bcrypt
- Rate limiting on API endpoints
- Input validation and sanitization
- CORS protection
- Helmet.js security headers
- SQL injection prevention with Sequelize ORM

## 📱 User Roles & Permissions

### Admin
- Full system access
- User management
- System configuration
- All CRUD operations

### Staff
- Customer management
- Inventory management
- Order management
- Delivery coordination

### Customer
- View/update own profile
- Place orders
- View order history
- Track deliveries

### Delivery Personnel
- View assigned deliveries
- Update delivery status
- Upload delivery proof

## 🚨 Troubleshooting

### Common Issues

1. **Database Connection Error**
   - Ensure MySQL is running
   - Verify database credentials in `.env`
   - Check if database exists

2. **Port Already in Use**
   - Change port in backend `.env` file
   - Kill existing processes: `npx kill-port 5000`

3. **CORS Issues**
   - Verify frontend URL in backend CORS configuration
   - Check API base URL in frontend

4. **Authentication Issues**
   - Clear browser localStorage
   - Check JWT secret in `.env`

### Database Reset
```bash
cd backend
npm run migrate:undo:all
npm run migrate
npm run seed
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/new-feature`
3. Commit changes: `git commit -am 'Add new feature'`
4. Push to branch: `git push origin feature/new-feature`
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- React team for the amazing framework
- Express.js for the robust backend framework
- Sequelize for excellent ORM capabilities
- Bootstrap for responsive design components
