# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Path to custom themes and plugins
ZSH_CUSTOM=$HOME/.dotfiles/oh-my-zsh-custom

# ZSH_THEME is disabled when using Starship prompt
# Starship handles the prompt rendering (see end of file)
ZSH_THEME=""

# Hide username in prompt
DEFAULT_USER=`whoami`

# OS Detection
case "$(uname -s)" in
    Darwin*)  OS_TYPE="macos" ;;
    Linux*)
        if grep -qi microsoft /proc/version 2>/dev/null; then
            OS_TYPE="wsl"
        else
            OS_TYPE="linux"
        fi
        ;;
esac

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
if [[ "$OS_TYPE" == "macos" ]]; then
    plugins=(git composer macos vagrant)
else
    plugins=(git composer)
fi

source $ZSH/oh-my-zsh.sh

# Removed old RVM path
#set numeric keys
# 0 . Enter
bindkey -s "^[Op" "0"
bindkey -s "^[Ol" "."
bindkey -s "^[OM" "^M"
# 1 2 3
bindkey -s "^[Oq" "1"
bindkey -s "^[Or" "2"
bindkey -s "^[Os" "3"
# 4 5 6
bindkey -s "^[Ot" "4"
bindkey -s "^[Ou" "5"
bindkey -s "^[Ov" "6"
# 7 8 9
bindkey -s "^[Ow" "7"
bindkey -s "^[Ox" "8"
bindkey -s "^[Oy" "9"
# + -  * /
bindkey -s "^[Ok" "+"
bindkey -s "^[Om" "-"
bindkey -s "^[Oj" "*"
bindkey -s "^[Oo" "/"

# Load the shell dotfiles, and then some:
# * ~/.dotfiles-custom can be used for other settings you don't want to commit.
for file in ~/.dotfiles/home/.{exports,aliases,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done

for file in ~/.dotfiles-custom/shell/.{exports,aliases,functions,zshrc}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Directory jumping now handled by zoxide (see modern tools section below)

# Hub removed - using gh CLI instead

# Sudoless npm https://github.com/sindresorhus/guides/blob/master/npm-global-without-sudo.md
NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$PATH:$NPM_PACKAGES/bin"
# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

export PATH=$HOME/.dotfiles/bin:$PATH

# Setup xdebug
export XDEBUG_CONFIG="idekey=VSCODE"

# Platform-specific configurations
if [[ "$OS_TYPE" == "macos" ]]; then
    # Homebrew
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # Zsh autosuggestions (brew location)
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

    # Zsh syntax highlighting (brew location)
    source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    # Import ssh keys in keychain
    ssh-add -A 2>/dev/null;

    # Laravel Herd
    export PATH="$HOME/Library/Application Support/Herd/bin":$PATH

    # macOS specific paths
    export PATH=/usr/local/bin:$PATH
    export PATH="$HOME/.composer/vendor/bin:$PATH"
    export PATH="$HOME/.yarn/bin:$PATH"

    # do not update all homebrew stuff automatically
    export HOMEBREW_NO_AUTO_UPDATE=1

    # Java & Android (macOS)
    export JAVA_HOME="$(brew --prefix)/opt/openjdk@17"
    export ANDROID_HOME="$HOME/Library/Android/sdk"
    export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$PATH"

    # Herd injected PHP configurations
    export HERD_PHP_84_INI_SCAN_DIR="/Users/ismail-dasci/Library/Application Support/Herd/config/php/84/"
    export HERD_PHP_85_INI_SCAN_DIR="/Users/ismail-dasci/Library/Application Support/Herd/config/php/85/"
    export HERD_PHP_83_INI_SCAN_DIR="/Users/ismail-dasci/Library/Application Support/Herd/config/php/83/"
    export HERD_PHP_82_INI_SCAN_DIR="/Users/ismail-dasci/Library/Application Support/Herd/config/php/82/"
    export HERD_PHP_81_INI_SCAN_DIR="/Users/ismail-dasci/Library/Application Support/Herd/config/php/81/"

elif [[ "$OS_TYPE" == "wsl" ]] || [[ "$OS_TYPE" == "linux" ]]; then
    # Linuxbrew (optional) or system packages
    if [ -d /home/linuxbrew/.linuxbrew ]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi

    # Zsh autosuggestions (apt location)
    [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
        source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

    # Zsh syntax highlighting (apt location)
    [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
        source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    # PHP/Composer (system)
    export PATH="$HOME/.config/composer/vendor/bin:$PATH"
    export PATH="$HOME/.composer/vendor/bin:$PATH"

    # Local bin (for fd, bat symlinks)
    export PATH="$HOME/.local/bin:$PATH"
fi

# WSL-specific configurations
if [[ "$OS_TYPE" == "wsl" ]]; then
    # Windows interop
    export BROWSER="wslview"

    # Windows home shortcut
    export WINHOME="/mnt/c/Users/$(cmd.exe /c 'echo %USERNAME%' 2>/dev/null | tr -d '\r')"

    # Clipboard (Windows)
    alias pbcopy="clip.exe"
    alias pbpaste="powershell.exe -command 'Get-Clipboard' | tr -d '\r'"

    # Windows commands from WSL
    alias explorer="explorer.exe"
    alias notepad="notepad.exe"

    # Open current folder in Windows Explorer
    alias open="explorer.exe ."

    # Quick navigation
    alias cdwin="cd \$WINHOME"
    alias cddownloads="cd /mnt/c/Users/\$USER/Downloads"
    alias cddesktop="cd /mnt/c/Users/\$USER/Desktop"
fi

# Common paths (all platforms)
export PATH=$HOME/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"

# Initialize modern tools
# zoxide - smarter cd
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# mise - unified version manager (replaces fnm, nvm, pyenv, etc.)
if command -v mise &> /dev/null; then
    eval "$(mise activate zsh)"
fi

# Atuin - shell history sync & search
if command -v atuin &> /dev/null; then
    eval "$(atuin init zsh)"
fi

# Starship prompt (modern cross-platform prompt)
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

# direnv - per-directory environment variables
if command -v direnv &> /dev/null; then
    eval "$(direnv hook zsh)"
fi

# fzf - fuzzy finder keybindings and completions
if command -v fzf &> /dev/null; then
    # Load fzf config (theme, preview settings)
    [ -f ~/.dotfiles/config/fzf/config.sh ] && source ~/.dotfiles/config/fzf/config.sh
    # fzf keybindings (Ctrl+T, Ctrl+R, Alt+C)
    source <(fzf --zsh 2>/dev/null) || true
fi

# carapace - universal shell completions
if command -v carapace &> /dev/null; then
    export CARAPACE_BRIDGES='zsh,bash'
    zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
    source <(carapace _carapace zsh)
fi
