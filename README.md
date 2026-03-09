# Ton's Environment

Dotfiles, shell config, keyboard layouts, and AI agent configuration.

## New Machine

```bash
git clone https://github.com/ton03/env.git ~/Ton/env
~/Ton/env/setup.sh
```

The setup script:
- Clones the work repo (`squareup/personal-antonn`) if missing
- Symlinks kage + ronin + skills into `~/.agents/`
- Sources shell config into `~/.zshrc`
- Installs Homebrew, git, node, python, ripgrep, pnpm
- Sets up Cursor, Claude Code, and Codex bridges

## What's Here

| Path | What |
|------|------|
| `.agents/kage/` | Kage (影) — personal shadow agent |
| `aliases.sh` | Shell aliases (git, navigation) |
| `functions.sh` | Shell functions |
| `zshrc.sh` | Zsh entrypoint |
| `bashrc.sh` | Bash entrypoint |
| `.p10k.zsh` | Powerlevel10k config |
| `keeb/` | Keyboard layouts (QMK/VIA) |
| `vscode/` | VS Code settings |
