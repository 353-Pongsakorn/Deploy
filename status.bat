@echo off
echo 📊 System Status Overview...

echo.
echo 🐳 Container Status:
docker-compose ps

echo.
echo ⚙️  Nginx Configuration Test:
docker-compose exec nginx nginx -t

echo.
echo 🏥 Service Health Checks:
echo Frontend/Nginx:
curl -s -I http://localhost | findstr "HTTP/1.1"
echo Backend API:
curl -s http://localhost/health

echo.
echo 📝 Recent Logs (last 10 lines):
docker-compose logs --tail=10
