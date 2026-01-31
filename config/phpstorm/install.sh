#!/bin/bash

# PHPStorm Settings Installer (Nuno Maduro Style)
# This script copies settings to PHPStorm config directory

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "PHPStorm Settings Installer"
echo "==========================="
echo ""

# Find PHPStorm config directory
PHPSTORM_DIR=""
for dir in ~/Library/Application\ Support/JetBrains/PhpStorm*; do
    if [ -d "$dir" ]; then
        PHPSTORM_DIR="$dir"
    fi
done

if [ -z "$PHPSTORM_DIR" ]; then
    echo -e "${RED}Error: PHPStorm config directory not found${NC}"
    echo "Make sure PHPStorm has been run at least once."
    exit 1
fi

echo -e "Found PHPStorm config: ${GREEN}$PHPSTORM_DIR${NC}"
echo ""

# Source directory
SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)"

# Backup existing settings
BACKUP_DIR="$PHPSTORM_DIR/backup_$(date +%Y%m%d_%H%M%S)"
echo -e "${YELLOW}Creating backup...${NC}"
mkdir -p "$BACKUP_DIR"

# Copy code styles
echo "Installing code style..."
mkdir -p "$PHPSTORM_DIR/codestyles"
if [ -f "$PHPSTORM_DIR/codestyles/NunoMaduroStyle.xml" ]; then
    cp "$PHPSTORM_DIR/codestyles/NunoMaduroStyle.xml" "$BACKUP_DIR/"
fi
cp "$SOURCE_DIR/codestyles/NunoMaduroStyle.xml" "$PHPSTORM_DIR/codestyles/"

# Copy inspections
echo "Installing inspections..."
mkdir -p "$PHPSTORM_DIR/inspection"
if [ -f "$PHPSTORM_DIR/inspection/NunoMaduroInspections.xml" ]; then
    cp "$PHPSTORM_DIR/inspection/NunoMaduroInspections.xml" "$BACKUP_DIR/"
fi
cp "$SOURCE_DIR/inspection/NunoMaduroInspections.xml" "$PHPSTORM_DIR/inspection/"

# Copy file templates
echo "Installing file templates..."
mkdir -p "$PHPSTORM_DIR/fileTemplates/includes"
cp "$SOURCE_DIR/fileTemplates/includes/PHP File Header.php" "$PHPSTORM_DIR/fileTemplates/includes/"

echo ""
echo -e "${GREEN}Installation complete!${NC}"
echo ""
echo "Next steps:"
echo "1. Restart PHPStorm"
echo "2. Go to Settings → Editor → Code Style → PHP"
echo "3. Select 'NunoMaduroStyle' from the Scheme dropdown"
echo "4. Go to Settings → Editor → Inspections"
echo "5. Select 'NunoMaduroInspections' from the Profile dropdown"
echo ""
echo "For Pint on Save:"
echo "1. Settings → Tools → Actions on Save"
echo "2. Enable 'Reformat code'"
echo "3. Settings → PHP → Quality Tools → Laravel Pint → Enable"
echo ""
echo -e "Backup saved to: ${YELLOW}$BACKUP_DIR${NC}"
