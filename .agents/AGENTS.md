# Ton's Coding Preferences

Personal conventions and preferences for AI-assisted development.

## General

- Ask before implementing if requirements are unclear
- Read existing code before editing — understand patterns already in use
- Don't reinvent — check for existing components, utilities, and conventions first
- Prefer editing existing files over creating new ones
- No unnecessary comments — code should be self-documenting. Comments only for non-obvious intent or trade-offs

## Tech Preferences

- **Package manager:** pnpm (not npm)
- **Frontend:** React, TypeScript, Vite, shadcn/ui, TanStack
- **Backend:** Python, FastAPI, SQLAlchemy, PostgreSQL
- **Linting:** Fast tools — oxlint, Ruff, tsgo
- **Utilities:** lodash-es
- **Deployment:** Railway
- **Monitoring:** Sentry
- **Issue tracker:** Linear

## Git

- **Commit frequently** — after every significant change
- Atomic, self-contained commits
- Use `git add <specific-files>` not `git add -A` (parallel sessions may have uncommitted changes)
- **Never push automatically** — only when explicitly asked
- Commit prefixes: `fix:`, `feat:`, `polish:`, `test:`, `refactor:`, `docs:`
- **Never use `--no-verify`** unless hooks are broken or just amending a message

## Testing

- Write tests for every feature and fix — not optional
- Bug fix workflow: write failing test first → fix → verify
- Backend: pytest
- Frontend: Vitest
- E2E: Playwright (mocked API, never touch real database)

## Development Order

1. **Scope** — define what's in and out
2. **Design** — check existing patterns and components
3. **Backend first** (if applicable) — models → schemas → API → tests
4. **Frontend** — types → API service → components → page integration
5. **Test** — unit tests for logic, E2E for user flows
6. **Polish** — responsive, dark mode, empty states, loading states

## Code Quality

- Lint and typecheck before committing
- Fix what you break — if you introduce linter errors, fix them
- Don't generate binary content, long hashes, or non-textual code

## Infrastructure

- Check migration state before creating new migrations (e.g. `alembic heads`)
- Verify deployments via logs after pushing to production
- Production is read-only — never modify production data during debugging

## Session Continuity

- Track progress in session logs when working across sessions
- Read task lists and session history before starting work
- Update progress continuously, not just at the end
