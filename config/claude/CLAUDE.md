## General

Do not tell me I am right all the time. Be critical. We're equals. Try to be neutral and objective.

Do not excessively use emojis.

Prefer using browser agent skill over using playwright directly.

## Coding Standards

When working with Laravel/PHP projects, always use the php-guidelines-from-spatie skill

## Using GitHub

For questions about GitHub, use the gh tool

---

## Nuno Maduro Style Laravel Configuration

Reference for ultra-strict, type-safe Laravel development.

### Required Dev Dependencies

```json
{
  "require-dev": {
    "larastan/larastan": "^3.3",
    "laravel/pint": "^1.22",
    "mockery/mockery": "^1.6",
    "nunomaduro/collision": "^8.8",
    "pestphp/pest": "^3.8",
    "pestphp/pest-plugin-faker": "^3.0",
    "pestphp/pest-plugin-laravel": "^3.2",
    "pestphp/pest-plugin-type-coverage": "^3.5",
    "rector/rector": "^2.0"
  }
}
```

### Composer Scripts

```json
{
  "scripts": {
    "setup": "composer install && cp .env.example .env && php artisan key:generate && php artisan migrate --seed && bun install",
    "dev": "npx concurrently \"php artisan serve\" \"php artisan queue:listen\" \"php artisan pail\" \"bun run dev\"",
    "lint": "./vendor/bin/rector process && ./vendor/bin/pint && bun run format",
    "test:lint": "./vendor/bin/rector process --dry-run && ./vendor/bin/pint --test",
    "test:types": "./vendor/bin/phpstan analyse --ansi --memory-limit=512M",
    "test:unit": "php artisan test --parallel --coverage --min=100",
    "test": "@test:lint && @test:types && @test:unit"
  }
}
```

### PHPStan Config (level: max)

```yaml
includes:
    - vendor/larastan/larastan/extension.neon
parameters:
    level: max
    paths: [app, config, database, routes]
```

### Config Files Location

All config templates are in `~/.dotfiles/config/laravel/`:
- `phpstan.neon` - Static analysis
- `rector.php` - Auto refactoring
- `pint.json` - Code style
- `composer-scripts.json` - Script reference

### Key Principles

1. **100% Type Coverage** - Every method, property, parameter typed
2. **PHPStan Level Max** - Strictest static analysis
3. **Rector** - Automated code modernization
4. **Pest** - Modern testing with coverage requirements
5. **Bun** - Fast npm alternative
6. **Fail-Fast** - Catch errors in development, not production

---

## Development Environment

### Terminal
- **App**: Ghostty
- **Font**: JetBrainsMono Nerd Font
- **Size**: 23
- **Theme**: Custom Claude Code (dark + orange accents)

### Tools
- **IDE**: PHPStorm / Cursor
- **PHP**: Laravel Herd
- **Database**: TablePlus / Sequel Ace
- **API**: HTTPie / Postman

### CLI Replacements
| Old | New | Alias |
|-----|-----|-------|
| ls | eza | ls, l, ll |
| cat | bat | cat |
| grep | ripgrep | grep |
| find | fd | - |
| top | btop | htop |
| du | dust | du |
| ps | procs | ps |
| git | lazygit | lg |
| docker | lazydocker | lzd |
