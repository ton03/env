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
# Symlinks
# ──────────────────────────────────────

echo ""
echo "Symlinks:"
link "$DIR/.agents" "$HOME/.agents"
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
# AI tool bridges
# ──────────────────────────────────────

echo ""
echo "AI tool bridges:"

# Cursor — kage skill
if [ -d "$HOME/.cursor" ]; then
  mkdir -p "$HOME/.cursor/skills"
  link "$HOME/.agents/kage" "$HOME/.cursor/skills/kage"
else
  echo "  - Cursor not found (skipping)"
fi

# Claude Code
CLAUDE_DIR="$HOME/.claude"
CLAUDE_MD="$CLAUDE_DIR/CLAUDE.md"
CLAUDE_LINE="Read ~/.agents/PROFILE.md at session start."
if command -v claude &>/dev/null || [ -d "$CLAUDE_DIR" ]; then
  mkdir -p "$CLAUDE_DIR"
  if [ -f "$CLAUDE_MD" ] && grep -qF "$CLAUDE_LINE" "$CLAUDE_MD"; then
    echo "  ✓ Claude Code bridge"
  else
    echo "$CLAUDE_LINE" >> "$CLAUDE_MD"
    echo "  → Claude Code bridge added"
  fi
else
  echo "  - Claude Code not found (skipping)"
fi

# ──────────────────────────────────────
# Done
# ──────────────────────────────────────

echo ""
echo "✅ Done! Restart your shell or run: source ~/.zshrc"
