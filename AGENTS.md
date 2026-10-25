# No Exit — Permanent Agent Instructions

**Project:** No Exit  
**Engine:** Godot 4 (exact version must be discovered from the actual repository/environment)  
**Primary development agent:** Antigravity CLI (`agy`)  
**Current approved prototype:** The Silent Place  
**Status:** Design discovery completed and approved; repository inspection still required.

This file defines durable project-specific behavior for coding agents. Read it before making changes.

---

## 1. Core mission

Develop *No Exit* as a distinctive first-person existential psychological horror game. Its primary horror source is not conventional enemies or constant jump scares. It is the player's experience of isolation, memory uncertainty, empty liminal architecture, silence, and a world whose rules cannot be trusted.

The first prototype, **The Silent Place**, must prove the atmosphere and the environmental transformation concept in a small, playable, testable experience before the project expands.

## 2. Source of truth and uncertainty

Read these files before substantial work:

1. `GAME_DESIGN.md`
2. `DESIGN_ANSWERS.md`
3. `ROADMAP.md`
4. `TASKS.md`
5. `TEST_PLAN.md`
6. `KNOWN_ISSUES.md`
7. `DEVLOG.md`
8. This file

Use the following precedence:
- Owner-confirmed decisions in `DESIGN_ANSWERS.md` and `GAME_DESIGN.md`.
- Current project facts verified by inspecting the repository.
- Acceptance criteria in `TASKS.md`.
- Roadmap proposals.
- Agent recommendations, clearly labeled as proposals.

Do not invent owner decisions, existing functionality, available assets, test results, engine version, or tool capability. Clearly label assumptions and unknowns.

The design is approved at the high-concept and prototype-direction level. Detailed implementation choices are not all approved individually. Prefer reversible, conservative defaults.

## 3. Mandatory repository inspection before implementation

At the start of a new session:
1. Confirm current working directory and repository root.
2. Inspect `git status --short`, current branch, and recent commit context when available.
3. Do not overwrite, reset, stash, clean, or discard existing user/team changes.
4. Inspect `project.godot`, the current Godot version, main scene, scene tree, scripts, input mappings, assets, autoloads, shaders, audio, plugins, README, and project conventions.
5. Identify whether the project is already playable and record its baseline state.
6. Find the correct Godot executable and establish commands that work in this environment.
7. Identify available testing tools and whether graphical computer control is actually available.
8. Map the approved prototype onto the existing architecture before editing.
9. Report conflicts between this plan and the current project rather than blindly restructuring it.

If this is not a Godot repository, do not create a parallel project or overwrite files without first explaining the mismatch and proposing a safe path.

## 4. First milestone boundary

The first milestone is **The Silent Place**: a small atmospheric first-person exploration slice.

It should demonstrate:
- First-person movement and collision.
- A quiet liminal environment with authored composition.
- Believable lighting, materials, and spatial sound.
- A small set of connected spaces.
- At least one repeatable environmental transformation that suggests memory.
- A clear beginning, progression, and ambiguous final moment.
- A repeatable test procedure.

Do not make full procedural world generation, complex enemy AI, a complete narrative, a final ending system, a large inventory, extensive combat, or multiple hours of content prerequisites for this milestone. Those are outside the approved first-prototype scope unless the owner changes it.

## 5. Autonomous task loop

For each task:
1. Read project instructions and the current task.
2. Inspect the current Git state.
3. Select the highest-priority ready task with satisfied dependencies.
4. Define or confirm measurable acceptance criteria.
5. Inspect relevant implementation and dependencies.
6. Make the smallest coherent change that meets the task.
7. Run relevant static checks, import checks, automated tests, and game launch checks.
8. Where possible, use real graphical interaction to test the actual gameplay behavior.
9. Inspect logs, warnings, scene/resource references, and the complete diff.
10. Fix failures and rerun the relevant checks.
11. Update task status, test evidence, devlog, and known issues.
12. Create a local checkpoint only when safe and consistent with repository rules.
13. Continue to the next ready task until the configured task/time budget ends, a real blocker appears, or an approval boundary is reached.

Do not stop after writing a plan if there is safe implementation work ready. Do not run an uncontrolled infinite loop. Use a bounded number of tasks or time budget supported by the environment and report the bound.

## 6. Review discipline

Review each change as if a separate reviewer were inspecting it:
- Does it satisfy the acceptance criteria?
- Does it follow the approved design?
- Does it introduce coupling or duplicated state?
- Does it break an existing feature or scene?
- Are error paths and transitions handled?
- Are names, types, resources, and node paths correct?
- Is the behavior testable?
- Does the diff include unrelated changes?
- Is documentation accurate?
- Are claims of success supported by evidence?

Do not claim that an atmosphere is emotionally successful solely because a scene loads. Technical verification and creative judgment are different.

## 7. Testing honesty

Use labels:
- **PASS:** the stated test ran and its expected result was observed.
- **FAIL:** the test ran and did not meet its expected result.
- **UNVERIFIED:** the necessary test or observation was not performed.
- **BLOCKED:** a required tool, decision, asset, or dependency is unavailable.
- **NOT APPLICABLE:** the test does not apply to the current feature.

A headless editor/import check does not prove that visual composition, audio, controls, or gameplay feel correct. Never describe unobserved behavior as verified.

## 8. Git and collaboration safety

Allowed by default when supported:
- Read files and inspect Git status.
- Edit scoped project files.
- Run approved local tests.
- Update project docs.
- Create local branches or local commits only if consistent with project policy and no unrelated changes are included.

Require explicit approval before:
- Pushing to a remote.
- Force-pushing, resetting a branch, or rewriting history.
- Deleting or mass-moving assets.
- Installing system packages or changing system configuration.
- Accessing credentials or secrets.
- Publishing releases, spending money, or making irreversible external changes.
- Replacing shared files where conflicts may exist.

Never:
- Use destructive cleanup commands on user data.
- Commit API keys, tokens, passwords, private keys, or personal credentials.
- Weaken tests to make them pass.
- silently discard teammate changes.
- Claim a commit or push occurred unless it actually did.

## 9. Code and scene architecture

Follow existing project conventions unless there is a clear reason to improve them. Avoid premature architecture and giant scripts. Prefer cohesive, testable components when they reduce complexity.

Potential systems for this project may include:
- Player movement and camera.
- Interaction detection and interaction lifecycle.
- Environment-state/transition coordinator.
- Memory-trigger or discovery state.
- Door/room connection state.
- Audio ambience controller.
- Minimal narration/voice event controller, only when needed.
- Debug/test hooks.

These are candidate responsibilities, not a mandate to create empty scripts for every system. Add a component only when the prototype needs it.

## 10. Atmosphere principles

- Silence is a design element, not an absence of work.
- Avoid constant music, constant ambient events, and random scare spam.
- Use contrast: ordinary spaces first, then carefully authored deviations.
- Use spatial sound sparingly and intentionally.
- Prefer one meaningful environmental inconsistency to many arbitrary effects.
- Preserve player observation time; do not constantly direct attention with UI.
- Keep the environment readable enough for exploration even when it is unsettling.
- Avoid relying on darkness alone to create fear.
- Do not reveal the full lore in the first prototype.

## 11. Reporting format

At the end of each autonomous cycle, report:
1. Current milestone and task.
2. What changed.
3. Files changed.
4. Tests actually run and results.
5. What was visually/gameplay verified.
6. What remains unverified.
7. Known issues and blockers.
8. Git checkpoint status.
9. Next task and why it is next.

Keep the report concise but evidence-based. Detailed evidence belongs in the task record and devlog.
