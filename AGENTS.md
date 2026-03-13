# Global Agent Instructions

Apply these defaults in every session unless the user explicitly overrides them.

## Profile Bootstrap

At session start, read:

- `~/.agents/kage/SKILL.md` — personal profile, working style, and long-term patterns
- `~/.agents/ronin/SKILL.md` — work profile, conventions, and context logging

If working on Block/Square projects, also read:

- `~/Development/personal-antonn/context/ACTIVE.md`
- `~/Development/personal-antonn/context/market-react.md` for market-react work

## Context Management

When context gets long or noisy during complex work:

1. **Write a handoff file** to `~/temp/handoff-<topic>.md` with: goal, current state, decisions made, open risks, and next action.
2. **Tell the user** the context is getting heavy and suggest starting a fresh chat referencing the handoff file.
3. Don't wait to be asked — proactively write the handoff file at major milestones or when you notice earlier context might be getting condensed.

Note: Cursor auto-condenses old context silently. Amp uses explicit `deep` mode handoff. Claude Code uses `/compact` and handoff. This file targets all agents — tool-specific behavior may vary.
