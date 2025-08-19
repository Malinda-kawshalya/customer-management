@echo off
echo 🚀 Setting up Customer Management System...

rem Backend setup
echo 📦 Installing backend dependencies...
cd backend
call npm install

echo ⚙️  Setting up environment...
if not exist .env (
    copy .env.example .env
    echo ✅ Created .env file from .env.example
    echo ⚠️  Please update the database credentials in .env file
)

echo 🗄️  Setting up database...
echo Make sure MySQL is running and create a database called 'customer_management_db'
pause

echo 🔄 Running database migrations...
call npm run migrate

echo 🌱 Running database seeders...
call npm run seed

rem Frontend setup
echo 📦 Installing frontend dependencies...
cd ..\frontend
call npm install

echo ✅ Setup completed!
echo.
echo 🎯 Next steps:
echo 1. Update backend/.env with your database credentials
echo 2. Start the backend server: cd backend ^&^& npm run dev
echo 3. Start the frontend server: cd frontend ^&^& npm start
echo.
echo 📚 Default credentials:
echo Admin: admin@customermanagement.com / admin123
echo Staff: staff@customermanagement.com / admin123
echo Customer: john.doe@example.com / admin123
echo Delivery: delivery@customermanagement.com / admin123
pause
