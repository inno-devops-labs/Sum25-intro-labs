#!/bin/bash
# cleanup.sh - Clean up Docker Lab 6 resources

echo "🧹 Docker Lab 6 - Cleanup"
echo "========================="

echo "Stopping all running containers..."
docker stop $(docker ps -q) 2>/dev/null || echo "No running containers to stop"

echo "Removing lab containers..."
docker rm -f ubuntu_container nginx_container my_website_container container1 container2 web web_new redis_container 2>/dev/null || echo "Some containers already removed"

echo "Removing temporary containers..."
docker rm -f temp1 temp2 temp3 2>/dev/null || echo "Temp containers already removed"

echo "Removing custom network..."
docker network rm lab_network 2>/dev/null || echo "Network already removed"

echo "Removing volumes..."
docker volume rm app_data 2>/dev/null || echo "Volume already removed"

echo "Removing custom images..."
docker rmi my_website:latest 2>/dev/null || echo "Custom image already removed"

echo "Removing exported tar file..."
rm -f ubuntu_image.tar

echo "Final cleanup - removing unused resources..."
docker system prune -a --volumes -f

echo "✅ Cleanup completed!"
echo "Lab environment has been reset."
