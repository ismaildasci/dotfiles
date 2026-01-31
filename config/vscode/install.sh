#!/bin/bash

# VSCode Settings Installer

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "VSCode Settings Installer"
echo "========================="
echo ""

VSCODE_DIR="$HOME/Library/Application Support/Code/User"
SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ ! -d "$VSCODE_DIR" ]; then
    echo "VSCode config directory not found. Creating..."
    mkdir -p "$VSCODE_DIR"
fi

# Backup
BACKUP_DIR="$VSCODE_DIR/backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

echo -e "${YELLOW}Creating backup...${NC}"
[ -f "$VSCODE_DIR/settings.json" ] && cp "$VSCODE_DIR/settings.json" "$BACKUP_DIR/"
[ -f "$VSCODE_DIR/keybindings.json" ] && cp "$VSCODE_DIR/keybindings.json" "$BACKUP_DIR/"

echo "Installing settings..."
cp "$SOURCE_DIR/settings.json" "$VSCODE_DIR/"
cp "$SOURCE_DIR/keybindings.json" "$VSCODE_DIR/"

echo ""
echo -e "${GREEN}Installation complete!${NC}"
echo ""
echo "Recommended extensions:"
cat "$SOURCE_DIR/extensions.json" | grep '"' | grep -v '//' | grep -v '{' | grep -v '}' | grep -v 'recommendations' | sed 's/[",]//g' | sed 's/^[ ]*/  /'
echo ""
echo "Install all with:"
echo "  cat ~/.dotfiles/config/vscode/extensions.json | grep '\"' | grep -v '//' | grep -v '{' | grep -v '}' | grep -v 'recommendations' | sed 's/[\",]//g' | xargs -I {} code --install-extension {}"
echo ""
echo -e "Backup saved to: ${YELLOW}$BACKUP_DIR${NC}"
