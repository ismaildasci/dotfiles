# dotfiles

Personal dotfiles for macOS, optimized for Laravel/PHP development.

## Install

```bash
git clone git@github.com:ismaildasci/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bin/install
```

## What's Inside

### Terminal

- **Ghostty** - GPU-accelerated terminal with custom theme
- **Oh My Zsh** - With custom agnoster theme
- **JetBrainsMono Nerd Font** - Size 23

### Modern CLI Tools

| Old | New | Notes |
|-----|-----|-------|
| ls | eza | Icons, git status |
| cat | bat | Syntax highlighting |
| find | fd | Simpler, faster |
| grep | ripgrep | Respects .gitignore |
| cd | zoxide | Smart directory jumping |
| top | btop | Better UI |
| du | dust | Visual disk usage |
| ps | procs | Colorful output |

### TUI Tools

- `lg` - lazygit
- `lzd` - lazydocker
- `y` - yazi file manager

### Laravel Shortcuts

```bash
a          # php artisan
p          # pest/phpunit
c          # composer
mfs        # migrate:fresh --seed
nah        # git reset --hard && git clean -df
```

### Navigation

```bash
z project  # Jump to directory
zi         # Interactive picker
Ctrl+R     # Fuzzy history search
Ctrl+T     # Fuzzy file finder
```

## Structure

```
~/.dotfiles/
├── bin/           # Scripts (install, update)
├── config/        # App configs (ghostty, claude, laravel templates)
├── home/          # Dotfiles (.zshrc, .gitconfig, .aliases)
├── macos/         # macOS preferences
└── oh-my-zsh-custom/  # Custom theme
```

### Symlinks Created

| Location | Target |
|----------|--------|
| `~/.zshrc` | `home/.zshrc` |
| `~/.gitconfig` | `home/.gitconfig` |
| `~/.config/ghostty/` | `config/ghostty/` |
| `~/.claude/` | `config/claude/` |

## Laravel Templates

Nuno Maduro style configs for strict, type-safe development:

```bash
cp ~/.dotfiles/config/laravel/phpstan.neon ./
cp ~/.dotfiles/config/laravel/rector.php ./
cp ~/.dotfiles/config/laravel/pint.json ./
```

- PHPStan level max
- Rector for automated refactoring
- Pint with strict rules

## PHPStorm Settings

Nuno Maduro style settings for strict PHP development:

```bash
~/.dotfiles/config/phpstorm/install.sh
```

Includes:
- Code style (PSR-12, trailing commas, strict formatting)
- Inspections (Pint, PHPStan, strict types, unused code)
- File watchers (Pint on save)
- File templates (`declare(strict_types=1)`)

## Claude Code

Skills and agents are version-controlled in `config/claude/`:

```bash
# Standalone install
curl -fsSL https://raw.githubusercontent.com/ismaildasci/dotfiles/main/bin/install-claude-code | bash
```

## Maintenance

```bash
bin/update   # Update everything
bin/doctor   # Health check
```

## License

MIT
