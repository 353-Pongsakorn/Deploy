#!/bin/bash
echo "🚀 Building Frontend and Docker Images..."

cd frontend
echo "📦 Building Frontend Static Files..."
npm run build
if [ $? -ne 0 ]; then
    echo "❌ Frontend build failed!"
    exit 1
fi
cd ..

echo "🐳 Building Docker Images..."
docker-compose build
if [ $? -ne 0 ]; then
    echo "❌ Docker build failed!"
    exit 1
fi

echo "✅ Build Complete!"
