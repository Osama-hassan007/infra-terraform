#!/bin/bash
apt-get update -y
apt-get install -y git php-cli unzip curl php-mbstring php-xml php-zip php-mysql composer
# create deploy dir and user
mkdir -p /var/www/laravel
chown -R ubuntu:ubuntu /var/www/laravel
# leave app checkout / deployment to GitHub Actions via SSH (we will pull into /var/www/laravel)
