#!/bin/bash
echo "🚀 Deploying Application (Local/Dev)..."

echo "🛑 Stopping existing containers..."
docker-compose down

echo "🔨 Building application..."
chmod +x build.sh
./build.sh
if [ $? -ne 0 ]; then exit 1; fi

echo "🆙 Starting services..."
docker-compose up -d

echo "📊 Status:"
docker-compose ps

echo "✅ Deployment Finished!"
echo "🌐 Frontend: http://localhost"
echo "📡 API: http://localhost/api/tasks"
echo "🏥 Health: http://localhost/health"
