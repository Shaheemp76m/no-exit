# No Exit — Agent Development Pack

This folder contains the approved design and autonomous-development workflow for No Exit.

## Files
- `AGENTS.md` — permanent agent behavior, safety, testing, and reporting rules.
- `DESIGN_ANSWERS.md` — exact record of all 20 owner-approved design answers.
- `GAME_DESIGN.md` — canonical game design and first prototype scope.
- `ROADMAP.md` — milestone plan.
- `TASKS.md` — prioritized task queue and acceptance criteria.
- `TEST_PLAN.md` — validation and gameplay test procedures.
- `KNOWN_ISSUES.md` — issue tracking.
- `DEVLOG.md` — development history.
- `DECISIONS_LOG.md` — durable decisions and rationale.
- `AGY_SETUP_PROMPT.md` — master prompt for Antigravity CLI.

## Installation into the repository
1. Make a backup or confirm the current Git state.
2. Extract/copy these Markdown files into the root of the existing No Exit repository.
3. If a same-named file already exists, compare and merge it instead of blindly overwriting it.
4. Start `agy` from the actual repository root.
5. Paste the contents of `AGY_SETUP_PROMPT.md`.
6. Let the agent inspect the project and validate the baseline before implementation.

## Important
The documents describe approved design and proposed work; they do not prove that any feature already exists. The agent must inspect the real repository, discover the actual Godot version and commands, preserve existing changes, and report test evidence honestly.
