#!/bin/bash
#
# Linux/WSL2 Package Installation
# Essential development tools via apt

set -e

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

step() { echo ""; echo -e "${BLUE}-->$NC $1"; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }

step "Updating package lists"
sudo apt update

step "Installing core tools"
sudo apt install -y \
    zsh git curl wget \
    build-essential \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg

step "Installing modern CLI tools"
sudo apt install -y \
    ripgrep \
    fd-find \
    bat \
    fzf \
    jq

# eza (modern ls) - needs separate repo
step "Installing eza"
if ! command -v eza &> /dev/null; then
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza
fi

step "Installing system monitoring tools"
sudo apt install -y \
    btop \
    ncdu \
    duf

step "Installing development tools"
sudo apt install -y \
    neovim \
    unzip zip \
    zsh-autosuggestions

step "Installing lazygit"
if ! command -v lazygit &> /dev/null; then
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm -f lazygit lazygit.tar.gz
fi

# Create symlinks for different binary names
step "Creating tool symlinks"
mkdir -p ~/.local/bin

# fd-find -> fd
if command -v fdfind &> /dev/null && [ ! -f ~/.local/bin/fd ]; then
    ln -sf $(which fdfind) ~/.local/bin/fd
    success "Linked fd"
fi

# batcat -> bat
if command -v batcat &> /dev/null && [ ! -f ~/.local/bin/bat ]; then
    ln -sf $(which batcat) ~/.local/bin/bat
    success "Linked bat"
fi

step "Installing zoxide (smarter cd)"
if ! command -v zoxide &> /dev/null; then
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
fi

step "Installing Atuin (shell history)"
if ! command -v atuin &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
fi

step "Installing fnm (Node.js version manager)"
if ! command -v fnm &> /dev/null; then
    curl -fsSL https://fnm.vercel.app/install | bash
fi

step "Installing Bun (fast npm alternative)"
if ! command -v bun &> /dev/null; then
    curl -fsSL https://bun.sh/install | bash
fi

step "Installing direnv (per-directory env vars)"
sudo apt install -y direnv

step "Installing Starship prompt"
if ! command -v starship &> /dev/null; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

step "Installing additional CLI tools"
sudo apt install -y \
    age \
    hyperfine \
    tokei

# yazi file manager (binary install)
step "Installing yazi (TUI file manager)"
if ! command -v yazi &> /dev/null; then
    YAZI_VERSION=$(curl -s "https://api.github.com/repos/sxyazi/yazi/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo yazi.zip "https://github.com/sxyazi/yazi/releases/latest/download/yazi-x86_64-unknown-linux-gnu.zip"
    unzip -o yazi.zip
    sudo install yazi-x86_64-unknown-linux-gnu/yazi /usr/local/bin
    rm -rf yazi.zip yazi-x86_64-unknown-linux-gnu
fi

# doggo DNS client
step "Installing doggo (modern DNS client)"
if ! command -v doggo &> /dev/null; then
    DOGGO_VERSION=$(curl -s "https://api.github.com/repos/mr-karan/doggo/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo doggo.tar.gz "https://github.com/mr-karan/doggo/releases/latest/download/doggo_${DOGGO_VERSION}_linux_amd64.tar.gz"
    tar xf doggo.tar.gz doggo
    sudo install doggo /usr/local/bin
    rm -f doggo doggo.tar.gz
fi

# croc secure file transfer
step "Installing croc (secure file transfer)"
if ! command -v croc &> /dev/null; then
    curl https://getcroc.schollz.com | bash
fi

success "APT packages installation complete!"
echo ""
echo "Note: Log out and back in, or run 'exec zsh' to reload shell"
