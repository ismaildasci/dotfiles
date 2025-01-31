# Contributing

Thanks for your interest in contributing to this dotfiles repository!

## How to Contribute

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

## Guidelines

### Code Style

- Keep shell scripts POSIX-compatible where possible
- Use meaningful variable names
- Add comments for non-obvious logic

### Testing

Before submitting, please test your changes:

```bash
# Run the install script in a fresh environment
bin/install

# Verify symlinks are created correctly
ls -la ~/ | grep -E '^\.'

# Test that shell starts without errors
zsh -l
```

### Documentation

- Update the README if you add new features
- Document any new aliases or functions
- Keep the package list in README up to date

## What to Contribute

- Bug fixes
- New useful aliases or functions
- Tool improvements
- Documentation improvements
- Shell performance optimizations

## What Not to Contribute

- Personal preferences that don't fit the general setup
- Breaking changes to existing functionality
- Proprietary tools or configurations

## Questions?

Feel free to open an issue or discussion if you have any questions!
