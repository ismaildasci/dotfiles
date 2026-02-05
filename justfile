# Dotfiles management commands
# https://github.com/casey/just

# Default: show available commands
default:
    @just --list

# Install dotfiles (OS-aware)
install:
    bash bin/install

# Update dotfiles and all tools
update:
    bash bin/update

# Install on macOS
install-macos:
    bash bin/install-macos

# Install on Linux/WSL2
install-linux:
    bash bin/install-linux

# Install Claude Code configuration
install-claude:
    bash bin/install-claude-code

# Show symlink status
status:
    @echo "Symlinks:"
    @ls -la ~/.zshrc 2>/dev/null || echo "  ~/.zshrc missing"
    @ls -la ~/.gitconfig 2>/dev/null || echo "  ~/.gitconfig missing"
    @ls -la ~/.config/ghostty/config 2>/dev/null || echo "  ~/.config/ghostty/config missing"
    @ls -la ~/.config/starship.toml 2>/dev/null || echo "  ~/.config/starship.toml missing"
    @ls -la ~/.config/nvim/init.lua 2>/dev/null || echo "  ~/.config/nvim/init.lua missing"
    @ls -la ~/.config/lazygit/config.yml 2>/dev/null || echo "  ~/.config/lazygit/config.yml missing"
    @ls -la ~/.config/zellij/config.kdl 2>/dev/null || echo "  ~/.config/zellij/config.kdl missing"

# Check which tools are installed
check:
    @echo "Tool Status:"
    @command -v mise >/dev/null 2>&1 && echo "  mise: $(mise --version)" || echo "  mise: not installed"
    @command -v zellij >/dev/null 2>&1 && echo "  zellij: $(zellij --version)" || echo "  zellij: not installed"
    @command -v eza >/dev/null 2>&1 && echo "  eza: $(eza --version | head -1)" || echo "  eza: not installed"
    @command -v bat >/dev/null 2>&1 && echo "  bat: $(bat --version)" || echo "  bat: not installed"
    @command -v fd >/dev/null 2>&1 && echo "  fd: $(fd --version)" || echo "  fd: not installed"
    @command -v rg >/dev/null 2>&1 && echo "  rg: $(rg --version | head -1)" || echo "  rg: not installed"
    @command -v fzf >/dev/null 2>&1 && echo "  fzf: $(fzf --version)" || echo "  fzf: not installed"
    @command -v lazygit >/dev/null 2>&1 && echo "  lazygit: $(lazygit --version | head -1)" || echo "  lazygit: not installed"
    @command -v starship >/dev/null 2>&1 && echo "  starship: $(starship --version)" || echo "  starship: not installed"
    @command -v atuin >/dev/null 2>&1 && echo "  atuin: $(atuin --version)" || echo "  atuin: not installed"
    @command -v zoxide >/dev/null 2>&1 && echo "  zoxide: $(zoxide --version)" || echo "  zoxide: not installed"
    @command -v carapace >/dev/null 2>&1 && echo "  carapace: $(carapace --version)" || echo "  carapace: not installed"
    @command -v gitleaks >/dev/null 2>&1 && echo "  gitleaks: $(gitleaks version)" || echo "  gitleaks: not installed"
    @command -v just >/dev/null 2>&1 && echo "  just: $(just --version)" || echo "  just: not installed"

# Backup current configs before changes
backup:
    @mkdir -p /tmp/dotfiles-backup
    @cp -r ~/.zshrc /tmp/dotfiles-backup/ 2>/dev/null || true
    @cp -r ~/.gitconfig /tmp/dotfiles-backup/ 2>/dev/null || true
    @cp -r ~/.config/ghostty /tmp/dotfiles-backup/ 2>/dev/null || true
    @echo "Backup saved to /tmp/dotfiles-backup/"
