# No Exit — Task Queue

**Current approved prototype:** The Silent Place  
**Queue policy:** Tasks are derived from the actual repository. Verify before duplicating work.

## Status labels
- `READY` — dependencies satisfied; can start.
- `IN PROGRESS` — actively being implemented.
- `BLOCKED` — waiting for a required dependency, tool, asset, or decision.
- `UNVERIFIED` — implementation exists but required validation has not been completed.
- `DONE` — acceptance criteria met with recorded evidence.
- `CANCELLED` — removed from scope by the owner or made obsolete.

## Priority labels
- `P0` — blocks project opening or all meaningful progress.
- `P1` — required for The Silent Place.
- `P2` — improves quality or reduces important risk.
- `P3` — optional polish or future expansion.

## Initial queue (provisional until repository inspection)

### NX-001 — Inspect repository and record baseline
- **Priority:** P0
- **Status:** READY
- **Dependencies:** None
- **Scope:** Inspect Git status, project files, Godot version, main scene, scripts, assets, input actions, autoloads, and available tests.
- **Acceptance criteria:**
  - [ ] Repository root and current branch identified.
  - [ ] `git status --short` recorded.
  - [ ] Godot version/executable identified or blocker recorded.
  - [ ] Main scene and launch method identified.
  - [ ] Existing functionality and project conventions summarized.
  - [ ] No user changes discarded.
- **Tests/evidence:** Actual commands and outputs recorded in devlog.

### NX-002 — Map approved design onto existing project
- **Priority:** P0
- **Status:** BLOCKED until NX-001 is complete
- **Dependencies:** NX-001
- **Scope:** Compare current project against `GAME_DESIGN.md` and `DESIGN_ANSWERS.md`.
- **Acceptance criteria:**
  - [ ] Existing systems mapped to prototype needs.
  - [ ] Duplicated work avoided.
  - [ ] Any conflicts documented.
  - [ ] First implementation task selected.
  - [ ] No invented design decisions.

### NX-003 — Establish reproducible validation commands
- **Priority:** P0
- **Status:** BLOCKED until NX-001 is complete
- **Dependencies:** NX-001
- **Scope:** Find working import/headless checks, game launch command, test tooling, and graphical testing capability.
- **Acceptance criteria:**
  - [ ] Exact commands documented.
  - [ ] At least one relevant project validation attempted.
  - [ ] Tool limitations recorded.
  - [ ] Headless checks are not misrepresented as gameplay testing.

### NX-004 — Define The Silent Place's playable route
- **Priority:** P1
- **Status:** BLOCKED until NX-002
- **Dependencies:** NX-002
- **Scope:** Choose a small route using existing assets where possible.
- **Acceptance criteria:**
  - [ ] Start point and end/reveal point defined.
  - [ ] A few connected spaces are enough to establish a baseline.
  - [ ] At least one repeat visit is possible.
  - [ ] The route is feasible for the current project and team.

### NX-005 — Implement or validate first-person movement
- **Priority:** P1
- **Status:** BLOCKED until NX-002
- **Dependencies:** NX-002
- **Scope:** Reuse or implement a simple first-person controller with collision and camera.
- **Acceptance criteria:**
  - [ ] Movement input works.
  - [ ] Collision prevents passing through solid geometry.
  - [ ] Camera stays stable and controls are documented.
  - [ ] Existing project behavior is preserved.
  - [ ] Test evidence is recorded.

### NX-006 — Build or adapt the baseline liminal environment
- **Priority:** P1
- **Status:** BLOCKED until NX-004 and NX-005
- **Dependencies:** NX-004, NX-005
- **Scope:** Create a small authored route with readable spaces, repetition, and negative space.
- **Acceptance criteria:**
  - [ ] Player can traverse the route.
  - [ ] Environment is coherent before transformation.
  - [ ] No critical collision or scene errors.
  - [ ] The route can be replayed.

### NX-007 — Establish restrained visual and audio atmosphere
- **Priority:** P1
- **Status:** BLOCKED until NX-006
- **Dependencies:** NX-006
- **Scope:** Tune lighting/materials and add sparse ambient sound only as justified.
- **Acceptance criteria:**
  - [ ] Visual style is consistent.
  - [ ] Important paths and details remain readable.
  - [ ] Sound is not constant or unnecessarily loud.
  - [ ] Audio works in the actual game.
  - [ ] Creative evaluation is marked unverified until playtested.

### NX-008 — Implement one deterministic environmental transformation
- **Priority:** P1
- **Status:** BLOCKED until NX-006
- **Dependencies:** NX-006
- **Scope:** Change a small number of authored environmental details based on a deliberate trigger or state.
- **Acceptance criteria:**
  - [ ] Trigger and result are deterministic.
  - [ ] The state change is perceptible.
  - [ ] The state can be reset/replayed for tests.
  - [ ] No broken node references or stuck transitions.
  - [ ] The change fits the memory-driven design without explaining the lore.

### NX-009 — Add an ambiguous environmental reveal
- **Priority:** P1
- **Status:** BLOCKED until NX-008
- **Dependencies:** NX-008
- **Scope:** End the slice with a small discrepancy suggesting the protagonist has been here before.
- **Acceptance criteria:**
  - [ ] Reveal occurs reliably.
  - [ ] It does not overexplain the story.
  - [ ] Player can restart or replay.
  - [ ] The route has a clear ending state.

### NX-010 — Full technical and creative verification
- **Priority:** P1
- **Status:** BLOCKED until NX-009
- **Dependencies:** NX-009
- **Scope:** Test the complete prototype, record issues, and report limitations.
- **Acceptance criteria:**
  - [ ] Launch/import checks run.
  - [ ] Movement and collision tested.
  - [ ] Environmental change tested repeatedly.
  - [ ] Audio and visual behavior observed where tools permit.
  - [ ] A full playthrough completed or marked unverified.
  - [ ] Known issues and next recommendation recorded.

## Task execution rules
- Reconcile this list with the real repository before implementing.
- If a task is already complete, verify it and mark it done with evidence.
- Split tasks that are too large to review.
- Do not mark a task done based only on code generation.
- Do not create placeholder systems with no use in the current milestone.

## Task template
### NX-XXX — Task title
- Priority:
- Status:
- Context:
- Dependencies:
- Scope:
- Acceptance criteria:
  - [ ] ...
- Test commands:
- Test results:
- Files changed:
- Evidence:
- Known limitations:
- Follow-up:
