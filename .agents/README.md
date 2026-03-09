# ~/.agents

Personal AI agent configuration. Tool-agnostic. One source of truth.

## Structure

```
~/Ton/env/.agents/              # git-backed (ton03/env)
├── AGENTS.md                   # coding preferences & conventions
├── PROFILE.md                  # who I am — personality, style, patterns
├── kage/
│   ├── SKILL.md                # full profile + hygiene
│   └── LOG.md                  # session observations over time
└── README.md                   # this file
```

## Setup

Symlink kage into discovery paths:

```bash
ln -sf ~/Ton/env/.agents/kage ~/.agents/kage
ln -sf ~/Ton/env/.agents/kage ~/.cursor/skills/kage
```

## Per-Tool Bridges

### Cursor

Discovered via `~/.cursor/skills/kage`.

### Claude Code

Reference in `~/.claude/CLAUDE.md`:

```markdown
Read ~/.agents/kage/SKILL.md at session start.
```

### Codex / Amp / Others

Most tools support an AGENTS.md or similar convention in the home directory.
If the tool reads `~/.agents/` or supports a global config, point it here.
Otherwise, add a reference in the tool's own config file.

## Adding New Skills

1. Create a folder in `~/Ton/env/.agents/` with a descriptive name
2. Add a `SKILL.md` (or plain markdown if tool-agnostic)
3. Symlink into tool-specific directories as needed
4. Update this README
