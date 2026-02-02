#!/bin/bash
#
# MySQL Setup for Linux/WSL2
# Installs MySQL 8.0 and creates dev user

set -e

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

step() { echo ""; echo -e "${BLUE}-->$NC $1"; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }

step "Installing MySQL 8.0"
sudo apt install -y mysql-server mysql-client

step "Starting MySQL service"
# Use systemd (WSL2 2026+ with systemd enabled)
sudo systemctl enable mysql
sudo systemctl start mysql

step "Creating dev user"
# Note: In WSL2, MySQL root has no password by default with auth_socket
sudo mysql -e "CREATE USER IF NOT EXISTS 'dev'@'localhost' IDENTIFIED BY 'dev';" || warn "User may already exist"
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'dev'@'localhost' WITH GRANT OPTION;"
sudo mysql -e "FLUSH PRIVILEGES;"

success "MySQL setup complete!"
echo ""
echo "Connection details:"
echo "  Host: localhost"
echo "  User: dev"
echo "  Password: dev"
echo ""
echo "Connect with: mysql -u dev -p"
echo ""
echo "MySQL is now enabled via systemd and will start on boot."
