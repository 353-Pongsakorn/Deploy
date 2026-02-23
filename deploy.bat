@echo off
echo 🚀 Deploying Application (Local/Dev)...

echo 🛑 Stopping existing containers...
docker-compose down

echo 🔨 Building application...
call build.bat
if %errorlevel% neq 0 exit /b %errorlevel%

echo 🆙 Starting services...
docker-compose up -d

echo 📊 Status:
docker-compose ps

echo ✅ Deployment Finished!
echo 🌐 Frontend: http://localhost
echo 📡 API: http://localhost/api/tasks
echo 🏥 Health: http://localhost/health
