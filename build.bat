@echo off
echo 🚀 Building Frontend and Docker Images...

cd frontend
echo 📦 Building Frontend Static Files...
call npm run build
if %errorlevel% neq 0 (
    echo ❌ Frontend build failed!
    exit /b %errorlevel%
)
cd ..

echo 🐳 Building Docker Images...
docker-compose build
if %errorlevel% neq 0 (
    echo ❌ Docker build failed!
    exit /b %errorlevel%
)

echo ✅ Build Complete!
