# PHPStorm Settings (Nuno Maduro Style)

Strict, type-safe PHP development settings inspired by Nuno Maduro's coding style.

## Quick Install

```bash
~/.dotfiles/config/phpstorm/install.sh
```

## What's Included

### Code Style (`codestyles/NunoMaduroStyle.xml`)
- PSR-12 compliant
- Trailing commas in arrays, parameters, match arms
- Short array syntax enforced
- `declare(strict_types=1)` compatible formatting
- Blank line before return statements
- 120 character line width

### Inspections (`inspection/NunoMaduroInspections.xml`)
- **Laravel Pint** validation enabled
- **PHPStan** validation enabled (level max)
- Missing strict types warning
- Missing return/param types warning
- Unused code detection
- Strict comparison enforcement
- Suggest `mb_*` string functions
- DateTime immutable suggestions
- Final class suggestions

### File Watchers (`options/watcherTasks.xml`)
- **Pint on save** - Auto-formats PHP files
- **Prettier** - For JS/TS/Vue/CSS (disabled by default)

### File Templates
- PHP files start with `declare(strict_types=1);`

### Editor Settings
- Strip trailing whitespace on modified lines
- Ensure newline at EOF
- Line numbers shown
- Indent guides enabled
- CamelHumps enabled

### UI Settings
- Navigation bar hidden (use shortcuts)
- Main toolbar hidden (minimal UI)
- Memory indicator shown

## Manual Setup (Alternative)

### 1. Code Style
1. Open PHPStorm → Settings → Editor → Code Style
2. Click gear icon → Import Scheme → IntelliJ IDEA code style XML
3. Select `codestyles/NunoMaduroStyle.xml`
4. Set as default

### 2. Inspections
1. Settings → Editor → Inspections
2. Click gear icon → Import Profile
3. Select `inspection/NunoMaduroInspections.xml`

### 3. File Watchers
1. Settings → Tools → File Watchers
2. Import `options/watcherTasks.xml`
3. Enable "Laravel Pint"

### 4. Quality Tools
1. Settings → PHP → Quality Tools
2. Configure Laravel Pint path: `$PROJECT_DIR$/vendor/bin/pint`
3. Configure PHPStan path: `$PROJECT_DIR$/vendor/bin/phpstan`

### 5. Pint on Save (Alternative Method)
1. Settings → Tools → Actions on Save
2. Enable "Reformat code"
3. Settings → PHP → Quality Tools → Laravel Pint
4. Enable "Run Laravel Pint on Reformat Code action"

## Keyboard Shortcuts to Learn

| Shortcut | Action |
|----------|--------|
| `Ctrl+T` / `Ctrl+Shift+T` | Refactor This menu |
| `Ctrl+Alt+L` | Reformat code |
| `Ctrl+Alt+O` | Optimize imports |
| `F2` | Go to next error |
| `Alt+Enter` | Quick fix |
| `Ctrl+Shift+F` | Find in files |
| `Ctrl+Shift+R` | Replace in files |
| `Shift+Shift` | Search everywhere |

## Project Requirements

For full functionality, your Laravel project should have:

```json
{
  "require-dev": {
    "larastan/larastan": "^3.0",
    "laravel/pint": "^1.0",
    "pestphp/pest": "^3.0",
    "rector/rector": "^2.0"
  }
}
```

And config files (available in `~/.dotfiles/config/laravel/`):
- `phpstan.neon`
- `pint.json`
- `rector.php`
