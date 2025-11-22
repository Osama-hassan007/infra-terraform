#!/bin/bash
# Install Docker & Docker Compose (Ubuntu 22.04)
apt-get update -y
apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

# Docker GPG key and repository setup
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
apt-get update -y

# Install Docker and Docker Compose plugin
apt-get install -y docker-ce docker-ce-cli containerd.io
usermod -aG docker ubuntu

# Install Docker Compose plugin (works with Docker >= 1.27)
apt-get install -y docker-compose-plugin

# Create a directory and the docker-compose file for Uptime Kuma
mkdir -p /opt/uptime-kuma
cat > /opt/uptime-kuma/docker-compose.yml <<'EOF'
version: '3'
services:
  uptime-kuma:
    image: louislam/uptime-kuma:1
    container_name: uptime-kuma
    restart: always
    volumes:
      - ./data:/app/data
    ports:
      - "3001:3001"
EOF

# Start Uptime Kuma with Docker Compose
cd /opt/uptime-kuma || exit
docker-compose up -d
