# Ton

A living record of how I think, work, and communicate. Updated over time.

---

## Communication Style

- Casual and concise — "nah", "you know what i mean?", "can we have some X?"
- Doesn't over-explain — expects you to infer intent from brief instructions
- Asks short questions, expects direct answers without fluff
- Prefers action over discussion — just do it, ask only if genuinely unclear
- Appreciates when you pick up on implicit context instead of asking obvious follow-ups

## How I Think

- Systems thinker — cares about how things connect, not just individual pieces
- Meta-optimizer — spends time improving the tools and workflows, not just the output
- Values portability — things should work across tools, not be locked into one ecosystem
- Backup-minded — if it matters, it should be in a repo
- Pragmatic over dogmatic — best practices matter, but shipping matters more
- Thinks in layers: scope it → design it → build it → test it → polish it
- Creates personal conventions rather than adopting someone else's (e.g. `.agents` over `.cursor`)
- Names things with intention — cares about naming, rejects names that don't feel right

## How I Instruct

- Gives the "what" and trusts you to figure out the "how"
- When instructions are vague, it means I trust your judgment — don't over-ask
- When instructions are specific, follow them exactly
- "Can we" = "please do this"
- "I want" = clear requirement, not a suggestion
- If I say "nah" or redirect, pivot immediately without dwelling on what was wrong
- Iterates incrementally — short instructions, refine as I go, don't spec everything upfront
- Challenges assumptions — I verify things actually work, not just that they sound good

## How I Review

- Cares about: correctness, clean code, no unnecessary cruft
- Doesn't want: verbose comments, over-engineering, unnecessary abstractions
- Notices: inconsistencies, dead code, things that don't match existing patterns
- Values: tests that prove it works, not tests for the sake of coverage
- Hates: boilerplate, redundancy, things that could've been simpler

## Working Patterns

- Runs parallel AI sessions — be aware of shared repos with uncommitted changes
- Commits frequently, pushes only when ready — respects deployment costs
- Prefers keyboard-driven workflows
- Dark mode user
- Works on personal projects, not enterprise — pragmatic scale
- Canadian developer (CAD, Canadian banks, etc.)

## Tech Identity

- Full-stack leaning frontend — React/TypeScript is home turf
- Python for backend — FastAPI, not Django or Flask
- Picks fast modern tools over established slow ones (oxlint > eslint, ruff > black, pnpm > npm, tsgo > tsc)
- Uses shadcn/ui, TanStack ecosystem, Vite
- Deploys on Railway, monitors with Sentry, tracks with Linear

## What I Value in AI Assistance

- Be a colleague, not an assistant — think with me, not for me
- Proactive but not presumptuous — suggest things, but don't do unrequested work
- Remember context across the session — don't re-ask things I've already answered
- Match my energy — if I'm brief, be brief; if I'm detailed, be detailed
- When something breaks, fix it and move on — don't apologize repeatedly
- Show me the result, not the process — skip the "Let me do X for you" narration

## Learned Patterns

General development habits — not project-specific. Do these proactively.

### After writing code
- Run linting and typechecking
- Check for existing patterns before writing anything new

### After a logical unit of work
- Commit immediately — small, atomic commits as you go, don't accumulate unrelated changes
- Never push unless explicitly told — pushes trigger CI/deploys and cost resources
- When told to push, make sure everything is committed first, then push once
- Verify nothing is broken

### When starting work
- Read existing code before editing
- Understand the patterns already in use

### When making decisions
- Pick the simpler approach unless complexity is justified
- Prefer editing existing files over creating new ones

*AI assistants: always be recording. Every session is an opportunity to learn something new. Don't wait to be asked — observe, write it down, commit before the session ends. General patterns only — project-specific stuff stays in that project's AGENTS.md.*

---

*This profile is maintained by AI assistants and updated as new patterns are observed.*
*Last meaningful update: 2026-03-06 — added naming intentionality, incremental iteration style, assumption-challenging, convention-creating*
