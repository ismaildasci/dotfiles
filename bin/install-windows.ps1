#Requires -RunAsAdministrator
<#
.SYNOPSIS
    Windows-side package installation using winget
.DESCRIPTION
    Installs essential Windows applications for development alongside WSL2
.NOTES
    Run from PowerShell as Administrator:
    powershell -ExecutionPolicy Bypass -File install-windows.ps1
#>

$ErrorActionPreference = "Continue"

function Write-Step($message) {
    Write-Host "`n--> " -ForegroundColor Blue -NoNewline
    Write-Host $message
}

function Write-Success($message) {
    Write-Host "[OK] " -ForegroundColor Green -NoNewline
    Write-Host $message
}

function Write-Warning($message) {
    Write-Host "[!] " -ForegroundColor Yellow -NoNewline
    Write-Host $message
}

Write-Host "`n=== Windows Development Environment Setup ===" -ForegroundColor Cyan
Write-Host "This will install essential Windows applications via winget`n"

# Check if winget is available
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Warning "winget not found. Please install App Installer from Microsoft Store."
    exit 1
}

Write-Step "Installing Windows Terminal"
winget install --id Microsoft.WindowsTerminal -e --accept-package-agreements --accept-source-agreements

Write-Step "Installing Git"
winget install --id Git.Git -e --accept-package-agreements

Write-Step "Installing JetBrains Mono Font"
winget install --id JetBrains.Mono -e --accept-package-agreements

Write-Step "Installing Visual Studio Code"
winget install --id Microsoft.VisualStudioCode -e --accept-package-agreements

Write-Step "Installing Docker Desktop"
winget install --id Docker.DockerDesktop -e --accept-package-agreements

Write-Step "Installing TablePlus"
winget install --id TablePlus.TablePlus -e --accept-package-agreements

Write-Step "Installing Postman"
winget install --id Postman.Postman -e --accept-package-agreements

Write-Step "Installing 1Password"
winget install --id AgileBits.1Password -e --accept-package-agreements

Write-Step "Installing KeePass"
winget install --id DominikReichl.KeePass -e --accept-package-agreements

# Optional: Browser
Write-Step "Installing Arc Browser"
winget install --id TheBrowserCompany.Arc -e --accept-package-agreements

# PowerToys (Rectangle alternative for Windows)
Write-Step "Installing PowerToys"
winget install --id Microsoft.PowerToys -e --accept-package-agreements

# Obsidian (Notes)
Write-Step "Installing Obsidian"
winget install --id Obsidian.Obsidian -e --accept-package-agreements

# Cursor IDE (Laravel/AI-powered development)
Write-Step "Installing Cursor"
winget install --id Anysphere.Cursor -e --accept-package-agreements

# Copy Windows Terminal settings
Write-Step "Configuring Windows Terminal"
$dotfilesPath = "$HOME\.dotfiles\windows\terminal\settings.json"
$wtSettingsDir = Get-ChildItem "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_*\LocalState" -ErrorAction SilentlyContinue | Select-Object -First 1

if ($wtSettingsDir -and (Test-Path $dotfilesPath)) {
    $wtSettingsPath = Join-Path $wtSettingsDir.FullName "settings.json"

    # Backup existing settings
    if (Test-Path $wtSettingsPath) {
        Copy-Item $wtSettingsPath "$wtSettingsPath.backup" -Force
        Write-Success "Backed up existing Windows Terminal settings"
    }

    Copy-Item $dotfilesPath $wtSettingsPath -Force
    Write-Success "Windows Terminal settings applied"
} else {
    Write-Warning "Could not find Windows Terminal settings directory or dotfiles"
    Write-Host "  Manual setup: Copy $dotfilesPath to Windows Terminal settings"
}

# Copy .wslconfig
Write-Step "Setting up .wslconfig"
$wslconfigSource = "$HOME\.dotfiles\windows\.wslconfig"
$wslconfigDest = "$HOME\.wslconfig"

if (Test-Path $wslconfigSource) {
    Copy-Item $wslconfigSource $wslconfigDest -Force
    Write-Success ".wslconfig copied to $wslconfigDest"
    Write-Warning "Run 'wsl --shutdown' to apply WSL2 resource limits"
} else {
    Write-Warning ".wslconfig not found in dotfiles"
}

Write-Host "`n=== Installation Complete ===" -ForegroundColor Green
Write-Host "`nNext steps:"
Write-Host "  1. Restart Windows Terminal"
Write-Host "  2. Install WSL2: wsl --install -d Ubuntu"
Write-Host "  3. Run 'wsl --shutdown' to apply .wslconfig"
Write-Host "  4. Clone dotfiles in WSL: git clone https://github.com/ismaildasci/dotfiles ~/.dotfiles"
Write-Host "  5. Run installer in WSL: cd ~/.dotfiles && ./bin/install"
Write-Host "`nDocker Desktop:"
Write-Host "  - Enable WSL2 backend in Docker Desktop settings"
Write-Host "  - Enable integration with your Ubuntu distro"
Write-Host ""
