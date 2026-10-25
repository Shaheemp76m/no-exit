# No Exit — Development Roadmap

**Approved first milestone:** The Silent Place  
**Strategy:** Prototype first; validate the experience before expanding scope.

## Roadmap rules
- Inspect the real repository before scheduling implementation.
- Adapt tasks to existing assets and architecture.
- Each milestone should produce a runnable, testable result.
- Keep long-term ideas out of the critical path until the prototype proves the core experience.
- Never claim a milestone is complete without evidence.
- If the project already has a feature, verify it before duplicating it.

---

## M0 — Repository audit and baseline

**Goal:** Understand the real project before changing it.

Deliverables:
- Verified repository root and Git status.
- Exact Godot version and executable path.
- Main scene, project settings, input actions, autoloads, scripts, assets, plugins, and existing architecture documented.
- Baseline launch/import checks attempted.
- Existing functionality and known blockers listed.
- Existing uncommitted changes preserved.

Exit criteria:
- The project can be described accurately.
- The agent knows how to launch it or has documented why not.
- No unrelated work was modified.

## M1 — Design and prototype implementation plan

**Goal:** Map the approved design to the existing project.

Deliverables:
- `GAME_DESIGN.md` aligned with actual repository constraints.
- Task breakdown with dependencies and acceptance criteria.
- One chosen small environment route.
- Technical plan for the environmental state change.
- A basic testing and evidence strategy.

Exit criteria:
- The next implementation task is clear and small.
- No major unresolved design decision blocks the first playable slice.

## M2 — First-person movement and baseline scene

**Goal:** Ensure the player can move through a stable space.

Potential tasks:
- Implement or validate the first-person controller.
- Configure collision and movement.
- Configure the camera and input actions.
- Build or adapt the first playable scene.
- Add restart/reset support for testing.

Exit criteria:
- The player can traverse the baseline scene.
- No major collision, input, or camera defects remain.
- Controls are documented.

## M3 — Liminal environment blockout

**Goal:** Establish spatial composition before expensive polish.

Potential tasks:
- Build a short route through a few connected spaces.
- Establish scale, sightlines, repetition, and negative space.
- Add a coherent visual baseline.
- Ensure players can understand where they can move.
- Create a repeatable route for testing.

Exit criteria:
- The route is traversable and visually coherent.
- The baseline space is stable enough for before/after comparisons.

## M4 — Lighting, materials, and silence

**Goal:** Establish the game's sensory identity.

Potential tasks:
- Define a restrained visual palette based on available assets.
- Configure lighting and materials.
- Add footsteps and minimal environmental room tone where appropriate.
- Establish quiet moments and sound transitions.
- Test volume balance and readability.

Exit criteria:
- The scene communicates a consistent liminal atmosphere.
- No constant music or random scare spam is needed.
- Lighting allows the player to observe important environmental details.

## M5 — First memory-like environmental transformation

**Goal:** Prove that the environment can change meaningfully and repeatably.

Potential tasks:
- Define a small environment-state model.
- Trigger a change through a deliberate condition, interaction, or route revisit.
- Change one or more authored details such as a prop, light, door, or connection.
- Make the state deterministic and resettable for testing.
- Avoid arbitrary randomization.

Exit criteria:
- The change occurs when expected.
- It can be reset and tested repeatedly.
- It does not break scene references or player navigation.
- The change is perceptible without relying on a loud cue.

## M6 — Prototype reveal and complete loop

**Goal:** Make The Silent Place feel like a small finished experience.

Potential tasks:
- Define a concise beginning and end state.
- Add one final environmental discrepancy suggesting the protagonist has been here before.
- Use narration only if it adds value and does not undermine silence.
- Provide a reliable restart/replay path.
- Record controls and the intended route.

Exit criteria:
- A new player can start, explore, notice a change, reach the reveal, and restart.
- The prototype does not need a full explanation of the mystery.

## M7 — Verification and owner playtest

**Goal:** Verify technical behavior and collect creative feedback.

Checks:
- Launch and import validation.
- Movement/collision.
- Repeatability of environmental state changes.
- Scene/resource integrity.
- Audio playback and volume.
- Visual composition and readability.
- Full playthrough.
- Owner feedback on pacing, atmosphere, and ambiguity.

Exit criteria:
- Critical technical issues are fixed or clearly documented.
- Unverified visual/creative issues are explicitly listed.
- The owner decides whether to polish, revise, or expand.

## M8 — Post-prototype decision

Only after M7, choose the next direction:
- Polish The Silent Place.
- Expand the memory/environment system.
- Build a second liminal space.
- Add a more complex observation puzzle.
- Prototype unreliable narration.
- Revisit the concept if the atmosphere is not working.

Do not automatically start every long-term feature. Use playtest evidence to choose.

## Future milestone ideas (not committed)

- Multiple liminal environment types.
- More complex room/route rearrangement.
- Interactive memory fragments.
- Audio/voice events.
- Sparse unreliable narration.
- Memory-driven puzzle sequences.
- Meaningful choices and ending variations.
- Save/checkpoint behavior if required.
- Accessibility and performance polish.

These remain proposals until the owner approves scope.
