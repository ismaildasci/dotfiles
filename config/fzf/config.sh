# fzf configuration
# Sourced from .zshrc

# Use fd for file search (respects .gitignore)
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

# Catppuccin Mocha theme
export FZF_DEFAULT_OPTS=" \
  --height 60% \
  --layout=reverse \
  --border rounded \
  --info=inline \
  --marker='>' \
  --pointer='>' \
  --prompt='> ' \
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Preview with bat for Ctrl+T
export FZF_CTRL_T_OPTS="
  --preview 'bat --style=numbers --color=always --line-range :300 {} 2>/dev/null || echo {}'
  --preview-window=right:60%:wrap
  --bind 'ctrl-/:toggle-preview'"

# Preview directory tree for Alt+C
export FZF_ALT_C_OPTS="
  --preview 'eza --tree --level=2 --icons --color=always {} 2>/dev/null || ls -la {}'
  --preview-window=right:50%"

# History search (Ctrl+R) - handled by Atuin, but kept as fallback
export FZF_CTRL_R_OPTS="
  --preview 'echo {}'
  --preview-window=down:3:wrap"
