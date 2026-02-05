#!/bin/bash

set -e

echo "=== Updating system ==="
sudo apt update && sudo apt upgrade -y

echo "=== Installing dependencies ==="
sudo apt install -y ca-certificates curl gnupg lsb-release

echo "=== Installing Docker ==="
sudo install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "=== Enabling Docker ==="
sudo systemctl enable docker
sudo systemctl start docker

echo "=== Adding current user to docker group ==="
sudo usermod -aG docker $USER || true

echo "=== Creating Nginx Proxy Manager directory ==="
mkdir -p ~/nginx-proxy-manager
cd ~/nginx-proxy-manager

echo "=== Creating docker-compose.yml ==="

cat <<EOF > docker-compose.yml
services:
  app:
    image: jc21/nginx-proxy-manager:latest
    container_name: nginx-proxy-manager
    restart: unless-stopped

    ports:
      - "80:80"
      - "443:443"
      - "81:81"

    environment:
      TZ: "Australia/Brisbane"

    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
EOF

echo "=== Starting Nginx Proxy Manager ==="
docker compose up -d

echo ""
echo "======================================"
echo "Nginx Proxy Manager installed!"
echo "Admin panel: http://SERVER_IP:81"
echo "======================================"
echo ""
echo "IMPORTANT: Logout/login again or run 'newgrp docker' to use docker without sudo."