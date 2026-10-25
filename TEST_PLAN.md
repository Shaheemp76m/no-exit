# No Exit — Test Plan

**Current focus:** The Silent Place  
**Purpose:** Validate technical correctness separately from creative effectiveness.

## 1. Test environment record
Record before testing:
- Repository root:
- Git branch and status:
- OS:
- Godot version:
- Godot executable:
- Main scene:
- Launch command:
- Test framework, if any:
- Graphical/computer-control tool availability:
- Date of test:

## 2. Test-result vocabulary
- **PASS:** test ran and expected behavior was observed.
- **FAIL:** test ran and expected behavior was not observed.
- **UNVERIFIED:** required observation/test was not performed.
- **BLOCKED:** required capability is missing.
- **NOT APPLICABLE:** test is outside current scope.

Never report a test as passing if it did not run.

## 3. Baseline and project integrity
- [ ] Record `git status --short` before work.
- [ ] Identify main scene and launch path.
- [ ] Check project imports/resource references.
- [ ] Run available static/project checks.
- [ ] Launch the existing project before major changes if possible.
- [ ] Record existing errors separately from newly introduced errors.
- [ ] Review `git diff` after changes.
- [ ] Confirm no unrelated assets or settings changed.

## 4. Example Godot checks
Discover the actual executable and project version first. The following are examples to adapt, not guaranteed commands:

```bash
godot --version
godot --headless --path . --editor --quit
godot --path .
```

The headless editor/import check can expose resource/import problems but does **not** prove the game plays correctly or looks atmospheric. Record actual command output and exit status.

## 5. First-person movement tests
For each test record steps, expected result, actual result, and evidence.

- [ ] Start the game and confirm the player appears in the intended start location.
- [ ] Test forward, backward, strafe, and diagonal movement.
- [ ] Verify solid geometry blocks movement.
- [ ] Verify the camera does not unexpectedly detach, rotate, or clip through geometry.
- [ ] Verify controls do not become stuck after focus changes or scene transitions.
- [ ] Test route completion and restart.
- [ ] Check runtime logs for errors.
- [ ] Confirm the controller remains responsive without unnecessary camera motion.

## 6. Environment route tests
- [ ] The player can navigate all intended spaces.
- [ ] Doorways and connections are readable.
- [ ] No required route is accidentally blocked.
- [ ] Collision shapes match the visible geometry closely enough.
- [ ] The player cannot fall out of the playable area unintentionally.
- [ ] The route can be replayed repeatedly.
- [ ] The baseline state is consistent between runs.

## 7. Environmental transformation tests
- [ ] The trigger occurs under the intended condition.
- [ ] The same input/route produces the same result.
- [ ] The changed object, light, door, or connection has the expected state.
- [ ] The change is not applied twice accidentally.
- [ ] The player cannot become permanently stuck during transition.
- [ ] Node references remain valid after the change.
- [ ] Reset/restart returns the environment to a known baseline.
- [ ] Repeated runs do not accumulate unintended changes.
- [ ] The transformation remains understandable enough to notice without explicit explanation.

## 8. Audio tests
- [ ] Footsteps or intended movement sounds play at the correct times.
- [ ] Environmental ambience is present only where intended.
- [ ] No audio loops unexpectedly continue after state changes.
- [ ] No abrupt clipping or excessive volume.
- [ ] Spatial cues, if used, match the source position.
- [ ] Silence remains an intentional part of the experience.
- [ ] The soundscape is tested in actual gameplay, not just by inspecting resource files.

## 9. Visual and atmosphere review
Technical checks cannot prove emotional impact. Use a real playthrough or a human tester.

- [ ] The baseline environment feels coherent and familiar enough to establish expectations.
- [ ] The player has time to observe the space.
- [ ] Lighting preserves readability.
- [ ] Important environmental details are not accidentally hidden.
- [ ] The change feels deliberate rather than random.
- [ ] The reveal suggests a question without overexplaining.
- [ ] The experience does not depend on jump scares.
- [ ] The atmosphere remains consistent with the approved design.
- [ ] Record owner feedback separately from agent judgment.

## 10. Regression checks
After each significant task:
- [ ] Main scene still launches.
- [ ] Existing player movement still works.
- [ ] Existing interactions remain functional.
- [ ] Scene references and resource paths remain valid.
- [ ] Input actions remain available.
- [ ] Restart/replay works.
- [ ] No new critical errors appear in logs.
- [ ] Diff contains only intended changes.

## 11. Test evidence template
### Test ID — Test title
- **Build/commit:**
- **Preconditions:**
- **Steps:**
- **Expected result:**
- **Actual result:**
- **Status:**
- **Evidence:**
- **Notes/limitations:**

## 12. Verification boundary
A successful import or headless run is not a full gameplay test. If the agent cannot operate the game window, mark graphical and creative tests UNVERIFIED and report exactly what tool is missing.
