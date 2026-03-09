#!/usr/bin/env bash
set -euo pipefail

# Setup script for ton03/env on a new machine.
# Run from anywhere — paths are absolute.
#
# Prerequisites:
#   - git access to ton03/env and squareup/personal-antonn
#   - Cursor and/or Claude Code installed

PERSONAL_REPO="$HOME/Ton/env"
WORK_REPO="$HOME/Development/antonn"

echo "=== Checking repos ==="

if [[ ! -d "$PERSONAL_REPO/.git" ]]; then
  echo "Cloning ton03/env → $PERSONAL_REPO"
  mkdir -p "$(dirname "$PERSONAL_REPO")"
  git clone https://github.com/ton03/env.git "$PERSONAL_REPO"
fi

if [[ ! -d "$WORK_REPO/.git" ]]; then
  echo "Cloning squareup/personal-antonn → $WORK_REPO"
  mkdir -p "$(dirname "$WORK_REPO")"
  git clone git@github.com:squareup/personal-antonn.git "$WORK_REPO"
fi

echo "=== Setting up ~/.agents ==="

mkdir -p "$HOME/.agents"

# Kage (personal) and Ronin (work)
ln -sfn "$PERSONAL_REPO/.agents/kage" "$HOME/.agents/kage"
ln -sfn "$WORK_REPO/.agents/ronin" "$HOME/.agents/ronin"

# Skills (from work repo backup)
if [[ -d "$WORK_REPO/.agents/skills" ]]; then
  ln -sfn "$WORK_REPO/.agents/skills" "$HOME/.agents/skills"
fi

echo "=== Setting up ~/.cursor (bridges only) ==="

mkdir -p "$HOME/.cursor/rules" "$HOME/.cursor/skills"

# Rules — thin pointers that tell Cursor where to look
for rule in "$WORK_REPO/.cursor/rules/"*.mdc; do
  [[ -f "$rule" ]] && cp "$rule" "$HOME/.cursor/rules/"
done

# Skill symlinks — Cursor discovers skills from ~/.cursor/skills/
ln -sfn "$HOME/.agents/kage" "$HOME/.cursor/skills/kage"
ln -sfn "$HOME/.agents/ronin" "$HOME/.cursor/skills/ronin"
for skill in "$HOME/.agents/skills/"*/; do
  name="$(basename "$skill")"
  ln -sfn "$skill" "$HOME/.cursor/skills/$name"
done

echo "=== Setting up ~/.claude ==="

mkdir -p "$HOME/.claude"
if [[ -f "$WORK_REPO/.claude/CLAUDE.md" ]]; then
  cp "$WORK_REPO/.claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
fi

echo "=== Setting up ~/.codex ==="

mkdir -p "$HOME/.codex/skills"
for skill in "$HOME/.agents/skills/"*/; do
  name="$(basename "$skill")"
  ln -sfn "$skill" "$HOME/.codex/skills/$name"
done

echo "=== Done ==="
echo ""
echo "Agents:"
ls -la "$HOME/.agents/kage" "$HOME/.agents/ronin"
echo ""
echo "Cursor rules:"
ls "$HOME/.cursor/rules/"*.mdc
echo ""
echo "Claude Code:"
ls "$HOME/.claude/CLAUDE.md"
