#!/bin/bash
#
# PHP and Composer Setup for Linux/WSL2
# Installs PHP 8.4 with Laravel-recommended extensions

set -e

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

step() { echo ""; echo -e "${BLUE}-->$NC $1"; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }

step "Adding Ondrej PHP PPA"
sudo add-apt-repository -y ppa:ondrej/php
sudo apt update

step "Installing PHP 8.4"
sudo apt install -y \
    php8.4-cli \
    php8.4-fpm \
    php8.4-common

step "Installing PHP extensions"
sudo apt install -y \
    php8.4-mysql \
    php8.4-pgsql \
    php8.4-sqlite3 \
    php8.4-redis \
    php8.4-memcached \
    php8.4-curl \
    php8.4-xml \
    php8.4-dom \
    php8.4-mbstring \
    php8.4-zip \
    php8.4-gd \
    php8.4-imagick \
    php8.4-intl \
    php8.4-bcmath \
    php8.4-soap \
    php8.4-readline

step "Installing Composer"
if ! command -v composer &> /dev/null; then
    EXPECTED_CHECKSUM="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')"
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

    if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]; then
        >&2 echo 'ERROR: Invalid installer checksum'
        rm composer-setup.php
        exit 1
    fi

    php composer-setup.php --quiet
    rm composer-setup.php
    sudo mv composer.phar /usr/local/bin/composer
    success "Composer installed"
else
    success "Composer already installed"
fi

step "Configuring Composer"
# Add Composer global bin to PATH (will be set in .zshrc)
mkdir -p ~/.config/composer

step "Installing global Composer packages"
composer global require laravel/installer || warn "laravel/installer failed"
composer global require laravel/envoy || warn "envoy failed"

success "PHP setup complete!"
echo ""
echo "Installed versions:"
php -v | head -1
composer --version
echo ""
echo "Global Composer packages are in: ~/.config/composer/vendor/bin"
echo "This path is added to PATH in .zshrc"
