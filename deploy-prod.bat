@echo off
echo ⚠️  WARNING: You are about to deploy to PRODUCTION!
set /p confirm="Are you sure? (y/n): "
if /i "%confirm%" neq "y" (
    echo ❌ Deployment cancelled.
    exit /b 0
)

echo 🚀 Deploying to PRODUCTION...

echo 🔨 Building frontend...
cd frontend
call npm run build
cd ..

echo 🐳 Starting production containers...
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d --build

echo ✅ Production Deployment Finished!
