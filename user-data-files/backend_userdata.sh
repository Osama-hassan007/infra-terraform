#!/bin/bash

# Update package list and install required software
apt-get update -y

# Add repository for PHP 8.2 and install PHP 8.2 and required extensions
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update
sudo apt-get install -y php8.2 php8.2-cli php8.2-mbstring php8.2-xml php8.2-zip php8.2-mysql php8.2-curl php8.2-bcmath php8.2-json unzip curl git composer

# Install PHP-FPM (if using Nginx/Apache)
sudo apt-get install -y php8.2-fpm

# Set PHP 8.2 as the default PHP version
sudo update-alternatives --set php /usr/bin/php8.2
sudo update-alternatives --set phpize /usr/bin/phpize8.2
sudo update-alternatives --set php-config /usr/bin/php-config8.2

# Verify the PHP version
php -v

# Create the directory for the Laravel app and set the appropriate permissions
mkdir -p /var/www/laravel
chown -R ubuntu:ubuntu /var/www/laravel

# Set up SSH access for GitHub (if using SSH for cloning)
mkdir -p /home/ubuntu/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFREFG8zJwmUBTtoE4w8+7GA2zQBqTCK9Ig/HXpPEPb19yTwWmvBvHN1OC9dxDXYKvAkb35Q9qcrC9plYtqg1giwmUnGV52VWQ/xHXNuQYwdzEMh8vO4wRq4ENB1nx4z/XzNUEyyfDyKCb/SyaxmLwDipPdaBg2ExDb+EclgMkxO6zWm6t/tcq5YubiuLinzhw64MO1L0V1K2ZH3PSkeMes1B1X94WQ8fzknUgeUMOLMhAv4YC3sgqx27SKVoHU9z+cAyD0pGpZ4Y47E6BpMLomvn3zy0JOFPGVAUIJR5s54l1lXAfHbnxCaqJhcgNEETOqnmIrfBrb9R3cKiiyleJ" >> /home/ubuntu/.ssh/authorized_keys
chown -R ubuntu:ubuntu /home/ubuntu/.ssh
chmod 700 /home/ubuntu/.ssh
chmod 600 /home/ubuntu/.ssh/authorized_keys

# Clone the Laravel repository if not already cloned
cd /var/www || exit
if [ ! -d "/var/www/laravel/.git" ]; then
  git clone https://github.com/laravel/laravel.git /var/www/laravel
fi

# Navigate to the Laravel project directory
cd /var/www/laravel || exit

# Pull the latest changes from the 12.x branch
git pull origin 12.x

# Run git config to fix ownership issues
sudo git config --global --add safe.directory /var/www/laravel

# Install PHP dependencies using Composer
composer install

# Run the database migrations
php artisan migrate --force  # The --force flag ensures migrations run in production

# Optionally, you can start PHP-FPM service (if Nginx/Apache is used)
# sudo service php8.2-fpm start
