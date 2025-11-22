#!/bin/bash

# Update package list and install required software
apt-get update -y
apt-get install -y git php-cli unzip curl php-mbstring php-xml php-zip php-mysql php-curl php-bcmath php-json composer

# Create the directory for the Laravel app and set the appropriate permissions
mkdir -p /var/www/laravel
chown -R ubuntu:ubuntu /var/www/laravel

# Set up SSH access for GitHub (if using SSH for cloning)
mkdir -p /home/ubuntu/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQChmyDyR39mYk2JWMUeFulXjSFEgFzCNQ0wkWMfzmwjh5VBtlRYMGfKM2A3mFZGvxHTl+mYRA2v4kPg/WP9Ztih4/ZwaUp85fUurSDpUk532FSc5Mc83+n1OBvhT/89YHvIg8FcOI9G5pB3+oseZARMroroAg9qldj1hLtqYP9A4/reHQCKkDGwqskAsnGU0nQk7Pavx+3uC3B9fJLyyUxRU2QFmH+54NNkFubxSVQptuXOJwU9iwvBVAjWmPS08DG41DDtkaoBn2RmEl9PBH5bHOJ3kBtUTVfVfb6p8c+SydJXvaHSvY52DdmpXlnodQ6QCtTz8F56gYWoppo2RxiT" >> /home/ubuntu/.ssh/authorized_keys
chown -R ubuntu:ubuntu /home/ubuntu/.ssh
chmod 700 /home/ubuntu/.ssh
chmod 600 /home/ubuntu/.ssh/authorized_keys

# Install PHP-FPM if using Nginx/Apache
apt-get install -y php-fpm

# The app deployment (git clone) will be handled by GitHub Actions via SSH
