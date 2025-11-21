#!/bin/bash
# install docker & docker-compose (Ubuntu 22.04)
apt-get update -y
apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io
usermod -aG docker ubuntu
# install docker-compose plugin
apt-get install -y docker-compose-plugin
# create a docker-compose for uptime-kuma
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

# start uptime-kuma
cd /opt/uptime-kuma
docker compose up -d
