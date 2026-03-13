#!/bin/bash
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
echo "🔧 Setting up from: $DIR"

# ──────────────────────────────────────
# Helpers
# ──────────────────────────────────────

link() {
  local src="$1" dst="$2"
  if [ -L "$dst" ]; then
    echo "  ✓ $dst (already linked)"
  elif [ -e "$dst" ]; then
    echo "  ⚠ $dst exists (skipping — back it up manually if needed)"
  else
    ln -sf "$src" "$dst"
    echo "  → $dst"
  fi
}

install_brew() {
  if brew list "$1" &>/dev/null; then
    echo "  ✓ $1"
  else
    echo "  Installing $1..."
    brew install "$1"
  fi
}

install_cask() {
  if brew list --cask "$1" &>/dev/null; then
    echo "  ✓ $1"
  else
    echo "  Installing $1..."
    brew install --cask "$1"
  fi
}

# ──────────────────────────────────────
# Directory structure
# ──────────────────────────────────────

echo ""
echo "Directories:"
mkdir -p "$HOME/Hack"
echo "  ✓ ~/Hack"

# ──────────────────────────────────────
# Homebrew
# ──────────────────────────────────────

echo ""
echo "Homebrew:"
if command -v brew &>/dev/null; then
  echo "  ✓ brew installed"
else
  echo "  Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# ──────────────────────────────────────
# Core tools
# ──────────────────────────────────────

echo ""
echo "CLI tools:"
install_brew "git"
install_brew "node"
install_brew "python"
install_brew "ripgrep"

if command -v pnpm &>/dev/null; then
  echo "  ✓ pnpm"
else
  echo "  Installing pnpm..."
  npm install -g pnpm
fi

# ──────────────────────────────────────
# Fonts
# ──────────────────────────────────────

echo ""
echo "Fonts:"
install_cask "font-fira-code"
install_cask "font-hack-nerd-font"

# ──────────────────────────────────────
# Git config
# ──────────────────────────────────────

echo ""
echo "Git:"
if [ -z "$(git config --global user.name)" ]; then
  git config --global user.name "Antonn Esquivel"
  echo "  → Set user.name"
else
  echo "  ✓ user.name = $(git config --global user.name)"
fi

if [ -z "$(git config --global user.email)" ]; then
  git config --global user.email "esquivel.antonn@gmail.com"
  echo "  → Set user.email"
else
  echo "  ✓ user.email = $(git config --global user.email)"
fi

# ──────────────────────────────────────
# SSH key
# ──────────────────────────────────────

echo ""
echo "SSH:"
if [ -f "$HOME/.ssh/id_ed25519" ] || [ -f "$HOME/.ssh/id_rsa" ]; then
  echo "  ✓ SSH key exists"
else
  echo "  ⚠ No SSH key found. Generate one:"
  echo "    ssh-keygen -t ed25519 -C \"esquivel.antonn@gmail.com\""
  echo "    Then add to GitHub: https://github.com/settings/keys"
fi

# ──────────────────────────────────────
# Work repo (squareup/personal-antonn)
# ──────────────────────────────────────

WORK_REPO="$HOME/Development/personal-antonn"

echo ""
echo "Work repo:"
if [ -d "$WORK_REPO/.git" ]; then
  echo "  ✓ $WORK_REPO"
else
  echo "  Cloning squareup/personal-antonn..."
  mkdir -p "$(dirname "$WORK_REPO")"
  git clone git@github.com:squareup/personal-antonn.git "$WORK_REPO"
fi

# ──────────────────────────────────────
# Symlinks
# ──────────────────────────────────────

echo ""
echo "Symlinks:"
link "$DIR/AGENTS.md" "$HOME/AGENTS.md"
link "$DIR/.p10k.zsh" "$HOME/.p10k.zsh"

# ──────────────────────────────────────
# Shell config
# ──────────────────────────────────────

ZSHRC="$HOME/.zshrc"
SOURCE_LINE="source \"$DIR/zshrc.sh\""

echo ""
echo "Shell:"
if [ -f "$ZSHRC" ] && grep -qF "$SOURCE_LINE" "$ZSHRC"; then
  echo "  ✓ zshrc.sh already sourced in .zshrc"
else
  echo "" >> "$ZSHRC"
  echo "# Ton's env" >> "$ZSHRC"
  echo "$SOURCE_LINE" >> "$ZSHRC"
  echo "  → Added source line to .zshrc"
fi

# ──────────────────────────────────────
# VS Code / Cursor settings
# ──────────────────────────────────────

echo ""
echo "Editor settings:"

VSCODE_DIR="$HOME/Library/Application Support/Code/User"
CURSOR_DIR="$HOME/Library/Application Support/Cursor/User"

if [ -d "$VSCODE_DIR" ]; then
  link "$DIR/vscode/settings_mac.json" "$VSCODE_DIR/settings.json"
else
  echo "  - VS Code not found (skipping)"
fi

if [ -d "$CURSOR_DIR" ]; then
  link "$DIR/vscode/settings_mac.json" "$CURSOR_DIR/settings.json"
else
  echo "  - Cursor not found (skipping)"
fi

# ──────────────────────────────────────
# ~/.agents — kage, ronin, skills
# ──────────────────────────────────────

echo ""
echo "Agents:"
mkdir -p "$HOME/.agents"

link "$DIR/.agents/kage" "$HOME/.agents/kage"
link "$WORK_REPO/.agents/ronin" "$HOME/.agents/ronin"

if [ -d "$WORK_REPO/.agents/skills" ]; then
  link "$WORK_REPO/.agents/skills" "$HOME/.agents/skills"
fi

# Also in skills/ for Amp/Codex discovery
link "$HOME/.agents/kage" "$HOME/.agents/skills/kage"
link "$HOME/.agents/ronin" "$HOME/.agents/skills/ronin"

# ──────────────────────────────────────
# AI tool bridges
# ──────────────────────────────────────

echo ""
echo "AI bridges:"

# Cursor — rules (thin pointers) + skill symlinks
if [ -d "$HOME/.cursor" ] || command -v cursor &>/dev/null; then
  mkdir -p "$HOME/.cursor/rules" "$HOME/.cursor/skills"

  for rule in "$WORK_REPO/.cursor/rules/"*.mdc; do
    [ -f "$rule" ] && cp "$rule" "$HOME/.cursor/rules/"
  done
  echo "  ✓ Cursor rules"

  link "$HOME/.agents/kage" "$HOME/.cursor/skills/kage"
  link "$HOME/.agents/ronin" "$HOME/.cursor/skills/ronin"
  for skill in "$HOME/.agents/skills/"*/; do
    [ -d "$skill" ] && link "$skill" "$HOME/.cursor/skills/$(basename "$skill")"
  done
  echo "  ✓ Cursor skills"
else
  echo "  - Cursor not found (skipping)"
fi

# Claude Code
if command -v claude &>/dev/null || [ -d "$HOME/.claude" ]; then
  mkdir -p "$HOME/.claude"
  if [ -f "$WORK_REPO/.claude/CLAUDE.md" ]; then
    cp "$WORK_REPO/.claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
    echo "  ✓ Claude Code (CLAUDE.md)"
  fi
else
  echo "  - Claude Code not found (skipping)"
fi

# Codex
if command -v codex &>/dev/null || [ -d "$HOME/.codex" ]; then
  mkdir -p "$HOME/.codex/skills"
  for skill in "$HOME/.agents/skills/"*/; do
    [ -d "$skill" ] && link "$skill" "$HOME/.codex/skills/$(basename "$skill")"
  done
  echo "  ✓ Codex skills"
else
  echo "  - Codex not found (skipping)"
fi

# Amp — reads from ~/.agents/skills/ directly, no extra wiring needed
if command -v amp &>/dev/null; then
  mkdir -p "$HOME/.config/amp"
  link "$HOME/AGENTS.md" "$HOME/.config/amp/AGENTS.md"
  echo "  ✓ Amp (reads ~/.agents/skills/)"
else
  echo "  - Amp not found (skipping)"
fi

# ──────────────────────────────────────
# Done
# ──────────────────────────────────────

echo ""
echo "✅ Done! Restart your shell or run: source ~/.zshrc"
