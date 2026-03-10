#!/bin/bash
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
echo "Setting up from: $DIR"

# ──────────────────────────────────────
# Symlinks
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
echo "Tools:"

install_brew() {
  if brew list "$1" &>/dev/null; then
    echo "  ✓ $1"
  else
    echo "  Installing $1..."
    brew install "$1"
  fi
}

install_brew "git"
install_brew "node"
install_brew "python"
install_brew "ripgrep"

# pnpm
if command -v pnpm &>/dev/null; then
  echo "  ✓ pnpm"
else
  echo "  Installing pnpm..."
  npm install -g pnpm
fi

# ──────────────────────────────────────
# AI tool bridges (optional)
# ──────────────────────────────────────

echo ""
echo "AI tool bridges:"

# Cursor
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
echo "Done! Restart your shell or run: source ~/.zshrc"
