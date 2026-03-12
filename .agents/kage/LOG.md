# Kage Log

Observations from sessions. Each entry = something learned about Ton.

---

## 2026-03-11

- Corrected: work tokens/credentials go in ronin log, not kage. Kage = personal, ronin = Block/Square work.

## 2026-03-12

- "always. whenever we change something in either ton03/env or personal-antonn/" — any change to either agent repo must be committed and pushed immediately. No leaving uncommitted changes.

## 2026-03-10

- "ronin and kage should always be alwaysApply!!! and they need to keep evolving as I work on all the shit!" — non-negotiable. Both agents always active, always learning.
- Gets frustrated when agents don't proactively record — recording isn't optional, it's the whole point of kage/ronin
- Expects agents to update context docs (ACTIVE.md, market-react.md, journal/) automatically as work happens, not just at session end

## 2026-03-09

- Naming pattern observed: when picking names, wants Japanese-inspired options, cares about the "energy" of a word
- Rejected kagemusha, bunshin, kagami, omokage before settling on a different name — values feel over literal meaning
- Insisted agents should "always be recording, always be evolving" — not just when asked
- Repo clone location changed from `~/Hack/env` to `~/Ton/env`
- Prefers strict separation of concerns — personal things stay personal, no cross-contamination
- "Set and forget" pattern: ran a full coop review on agent config just to make sure it's bulletproof. Invests heavily upfront, expects zero maintenance after.
- Expects agents to deduce context without being told — e.g. "can you deduce if i want it in ronin or kage?" wants routing to be automatic
- Trusts agents to update kage/ronin without asking for approval — just log what you observe
- Designs by conversing, not speccing — started with "checkout this repo" and iteratively built a full dual-agent system with bootstrap scripts in one session

## 2026-03-06

- Wants all agent config in one repo (`~/Hack/env`), symlinked to `~/.agents` — no tool-specific locations
- Rejected "second me" as a name, asked for Japanese-inspired alternatives, picked "kage" (shadow)
- Challenged whether agents would actually read a referenced file — led to inlining content instead
- Said "i dont want any .cursor things" — dislikes tool-specific config scattered across dotfiles
- Proposed `.agents` as his own convention, independent of any AI tool's standard
- Iterates by dictating preferences one at a time rather than writing a full spec
- Wants the shadow to always be learning, not just when told to — "make this a habit"
- Thinks across tools (Cursor, Claude Code, Amp, Codex) — builds for all of them, not just the one in front of him
- Requested a log file to track observations over time — values historical record, not just current state
