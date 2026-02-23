@echo off
echo 🔍 Testing API Endpoints...

echo.
echo 1. Testing Root Health:
curl -w "\nTime: %%{time_total}s\n" http://localhost/health

echo.
echo 2. Testing Backend Demo Endpoint (via Proxy):
curl -w "\nTime: %%{time_total}s\n" http://localhost/api/demo

echo.
echo 3. Testing Real API Endpoint (Tasks):
curl -w "\nTime: %%{time_total}s\n" http://localhost/api/tasks

echo.
echo ✅ API Tests Completed!
