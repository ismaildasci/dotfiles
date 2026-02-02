#!/bin/bash
#
# Linux/WSL2 System Defaults
# Optimizations for development (macOS set-defaults.sh equivalent)

set -e

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

step() { echo ""; echo -e "${BLUE}-->$NC $1"; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }

echo ""
step "Linux/WSL2 System Defaults"
echo ""

# Detect WSL
IS_WSL=false
if grep -qi microsoft /proc/version 2>/dev/null; then
    IS_WSL=true
fi

# =============================================================================
# inotify limits (critical for file watchers: Vite, Webpack, phpunit-watcher)
# =============================================================================
step "Setting inotify limits"

SYSCTL_CONF="/etc/sysctl.conf"

# max_user_watches: Number of files that can be watched
if ! grep -q "fs.inotify.max_user_watches" $SYSCTL_CONF; then
    echo "fs.inotify.max_user_watches=524288" | sudo tee -a $SYSCTL_CONF
    success "Set max_user_watches=524288"
else
    warn "max_user_watches already configured"
fi

# max_user_instances: Number of inotify instances per user
if ! grep -q "fs.inotify.max_user_instances" $SYSCTL_CONF; then
    echo "fs.inotify.max_user_instances=1024" | sudo tee -a $SYSCTL_CONF
    success "Set max_user_instances=1024"
else
    warn "max_user_instances already configured"
fi

# =============================================================================
# Swappiness (lower value for SSD longevity)
# =============================================================================
step "Setting swappiness"

if ! grep -q "vm.swappiness" $SYSCTL_CONF; then
    echo "vm.swappiness=10" | sudo tee -a $SYSCTL_CONF
    success "Set swappiness=10"
else
    warn "swappiness already configured"
fi

# =============================================================================
# File descriptor limits
# =============================================================================
step "Setting file descriptor limits"

if ! grep -q "fs.file-max" $SYSCTL_CONF; then
    echo "fs.file-max=2097152" | sudo tee -a $SYSCTL_CONF
    success "Set file-max=2097152"
else
    warn "file-max already configured"
fi

# =============================================================================
# Apply sysctl changes
# =============================================================================
step "Applying sysctl changes"
sudo sysctl -p
success "sysctl changes applied"

# =============================================================================
# WSL-specific: Git credential helper (uses Windows Git Credential Manager)
# =============================================================================
if [ "$IS_WSL" = true ]; then
    step "Configuring Git credential helper for WSL"

    # Check if Windows Git Credential Manager exists
    GCM_PATH="/mnt/c/Program Files/Git/mingw64/bin/git-credential-manager.exe"
    if [ -f "$GCM_PATH" ]; then
        git config --global credential.helper "$GCM_PATH"
        success "Git credential helper set to Windows GCM"
    else
        warn "Windows Git Credential Manager not found at: $GCM_PATH"
        warn "Install Git for Windows to enable credential sharing"
    fi
fi

# =============================================================================
# User limits (ulimit)
# =============================================================================
step "Configuring user limits"

LIMITS_CONF="/etc/security/limits.conf"

# Check and add open files limit
if ! grep -q "nofile" $LIMITS_CONF 2>/dev/null; then
    echo "* soft nofile 65535" | sudo tee -a $LIMITS_CONF
    echo "* hard nofile 65535" | sudo tee -a $LIMITS_CONF
    success "Set nofile limits"
else
    warn "nofile limits already configured"
fi

# =============================================================================
# Done
# =============================================================================
echo ""
success "System defaults configured!"
echo ""
echo "Current values:"
echo "  inotify.max_user_watches: $(cat /proc/sys/fs/inotify/max_user_watches)"
echo "  inotify.max_user_instances: $(cat /proc/sys/fs/inotify/max_user_instances)"
echo "  vm.swappiness: $(cat /proc/sys/vm/swappiness)"
echo "  fs.file-max: $(cat /proc/sys/fs/file-max)"
echo ""

if [ "$IS_WSL" = true ]; then
    echo "WSL2 Note: Some settings may require 'wsl --shutdown' to take effect."
    echo ""
fi
