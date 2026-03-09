# ~/.agents

Personal AI agent configuration. Tool-agnostic. One source of truth.

## Structure

```
~/.agents/                  # symlink → ~/Hack/env/.agents/
├── AGENTS.md               # coding preferences & conventions
├── PROFILE.md              # who I am — personality, style, patterns
├── kage/
│   └── SKILL.md            # full profile + hygiene (Cursor-compatible)
└── README.md               # this file
```

## Setup

Source of truth is `~/Hack/env/.agents/` (git-backed). Symlinked to home:

```bash
ln -sf ~/Hack/env/.agents ~/.agents
```

## Per-Tool Bridges

Each AI tool has its own discovery mechanism. Set up once per tool:

### Cursor

Symlink kage into Cursor's skill directory:

```bash
mkdir -p ~/.cursor/skills
ln -sf ~/.agents/kage ~/.cursor/skills/kage
```

### Claude Code

Reference in `~/.claude/CLAUDE.md`:

```markdown
Read ~/.agents/PROFILE.md and ~/.agents/AGENTS.md at session start.
```

### Codex / Amp / Others

Most tools support an AGENTS.md or similar convention in the home directory.
If the tool reads `~/.agents/` or supports a global config, point it here.
Otherwise, add a reference in the tool's own config file.

## Adding New Skills

1. Create a folder in `~/.agents/` with a descriptive name
2. Add a `SKILL.md` (or plain markdown if tool-agnostic)
3. Symlink into tool-specific directories as needed
4. Update this README
