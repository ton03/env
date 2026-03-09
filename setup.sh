#!/bin/bash
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
echo "Setting up from: $DIR"

# ──────────────────────────────────────
# Work repo (squareup/personal-antonn)
# ──────────────────────────────────────

WORK_REPO="$HOME/Development/antonn"

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

link() {
  local src="$1" dst="$2"
  if [ -L "$dst" ]; then
    rm "$dst"
    ln -sf "$src" "$dst"
    echo "  ↻ $dst"
  elif [ -e "$dst" ]; then
    echo "  ⚠ $dst exists (skipping — back it up manually if needed)"
  else
    ln -sf "$src" "$dst"
    echo "  → $dst"
  fi
}

echo ""
echo "Symlinks:"
link "$DIR/.p10k.zsh" "$HOME/.p10k.zsh"

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

if command -v pnpm &>/dev/null; then
  echo "  ✓ pnpm"
else
  echo "  Installing pnpm..."
  npm install -g pnpm
fi

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

# ──────────────────────────────────────
# Done
# ──────────────────────────────────────

echo ""
echo "Done! Restart your shell or run: source ~/.zshrc"
