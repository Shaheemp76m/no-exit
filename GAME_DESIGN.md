# No Exit — Canonical Game Design Document

**Document status:** Approved high-level concept and first-prototype direction  
**Working title:** No Exit  
**Prototype title:** The Silent Place  
**Engine:** Godot 4; exact version must be discovered from the existing repository  
**Primary development agent:** Antigravity CLI (`agy`)  
**Project stage:** Experimental prototype  
**Design source:** `DESIGN_ANSWERS.md`

---

## 1. High concept

*No Exit* is a first-person existential psychological horror game in which a silent, dreamlike liminal world changes around a protagonist who has been there before. Through memory-driven environmental changes, impossible architecture, and unreliable narration, the player gradually questions whether the world is real, whether the protagonist can trust their own experience, and whether escape is possible.

The game does not need conventional enemies to create danger. The environment itself is the threat.

## 2. Design pillars

### Pillar 1 — Existential dread
The player should feel isolated and uncertain. The game raises questions about repetition, identity, memory, and escape without explaining every mystery immediately.

### Pillar 2 — Liminal familiarity
Spaces should be recognizable in category—corridors, waiting rooms, empty public buildings, streets—but feel wrong in their arrangement, scale, emptiness, or behavior.

### Pillar 3 — Silence with purpose
Silence is active design. Footsteps, room tone, distant hums, and occasional sounds gain meaning because the game avoids constant music and noise.

### Pillar 4 — Memory changes the world
Changes should have an authored relationship to discoveries or remembered events. Avoid arbitrary random changes that feel like unrelated gimmicks.

### Pillar 5 — Unreliable understanding
The protagonist's interpretation or narration may contradict what the player sees. The player is invited to notice discrepancies rather than receive constant explanations.

### Pillar 6 — Small, polished prototype first
Prove one experience before scaling the game. Prefer a short, cohesive slice over a broad collection of unfinished mechanics.

## 3. Genre and player experience

- **Primary genre:** First-person psychological horror.
- **Central theme:** Existential dread.
- **Core experience:** Explore, observe, notice inconsistencies, experience environmental changes, and form uncertain interpretations.
- **Primary source of threat:** The environment and uncertainty.
- **Conventional enemies:** Not part of the approved first prototype.
- **Combat:** Not part of the approved first prototype.
- **Desired player response:** Unease, curiosity, disorientation, careful observation, and lingering uncertainty.
- **Pacing:** Deliberate. Give players time to inspect and interpret spaces.
- **Jump scares:** Do not rely on them as the primary source of fear.

## 4. The world

### 4.1 Liminal environments
The full game may combine:
- Empty corridors and hallways.
- Abandoned public interiors.
- Waiting rooms and transitional spaces.
- Empty streets or neighborhoods.
- Staircases, doors, and passages with impossible connections.
- Familiar spaces whose arrangement changes.

These are a palette of possible environments, not a requirement to build all of them in the first slice.

### 4.2 World rules
The environment can change in response to the protagonist's memories and progression. Changes may affect:
- Object presence or placement.
- Lighting state.
- Door state.
- Visible destinations.
- Room-to-room connections.
- Spatial proportions or the perceived continuity of a space.
- Audio heard from a location.
- Small details that suggest the protagonist recognizes a place.

For the first prototype, changes must be authored, deterministic, testable, and repeatable. Avoid a general-purpose procedural world system until the concept has been validated.

### 4.3 Familiarity before impossibility
Begin with a coherent, readable environment. Establish the expected layout and sensory rules. Break those rules selectively. If every object and corridor is strange from the beginning, the player has no stable baseline from which to notice a meaningful change.

## 5. Protagonist

The protagonist has been in this world before but cannot initially remember why.

Confirmed:
- First-person perspective.
- The character's past is connected to the experience in some way.
- Memory and perception are unreliable themes.

Not yet defined:
- Name, age, appearance, voice, biography, motive, or the ultimate explanation.
- Whether the protagonist consciously recognizes the place at the beginning.
- Whether narration is internal monologue, recorded speech, or another format.

Do not invent a definitive backstory during prototype implementation. Use placeholder narration or no narration unless the owner later approves specific content.

## 6. Core gameplay loop

The intended full-game loop is:

1. Enter or revisit a liminal space.
2. Explore and observe the environment.
3. Notice a discrepancy, clue, or memory-related trigger.
4. Interact or investigate.
5. Experience a change in the environment or the protagonist's interpretation.
6. Use the new information to explore further.
7. Gradually question the reliability of the space and the protagonist's memories.

The first prototype only needs a compact version of this loop.

## 7. Perspective, controls, and movement

### Confirmed
- First-person camera.
- Exploration is central.

### Not yet confirmed
- Walking and sprinting speeds.
- Jumping.
- Crouching.
- Head bob or camera sway.
- Body/hand visibility.
- Controller support.
- Interaction input.
- Whether movement should be realistic, floaty, slow, or deliberately heavy.

### Prototype defaults
Inspect the existing controller first. If none exists, implement responsive conventional first-person movement with collision and a simple, comfortable camera. Do not add exaggerated head bob, forced slow movement, sprint stamina, or jumping unless needed and approved. Expose key movement parameters for tuning.

## 8. Interaction philosophy

Use a combination:
- Simple, unobtrusive interactions for ordinary objects.
- More physical, authored interactions when the moment matters.
- Environmental manipulation for selected puzzles.
- Observation-based discovery.

Prototype priority:
- A clear, consistent way to interact with one or two objects if the experience requires it.
- No complicated inventory unless a real design need emerges.
- No generic UI prompt over every environmental detail.
- Do not turn every object into an interactable; visual storytelling can be non-interactive.

## 9. Memory system

Memory revelation can use:
- Environmental storytelling.
- Interactive memory fragments.
- Audio and voices.
- Surreal sequences.

These are long-term channels, not a requirement to build four large systems immediately.

For the first prototype:
- Use one simple memory-like trigger or scripted environmental state transition.
- Keep the trigger deterministic.
- Make the change visible enough to be testable but subtle enough to preserve atmosphere.
- Do not explain the full meaning of the change.

Potential future architecture:
- A small state or event representing a discovery.
- Authored environment states.
- Trigger volumes or interactions that request transitions.
- A coordinator that applies the change to selected nodes.
- Clear transition rules and reset/test support.

Do not build a complex memory database until multiple real use cases justify it.

## 10. Puzzles and spatial logic

Puzzle style is layered:
1. Subtle observation.
2. Recognizing differences.
3. Environmental manipulation.
4. Memory-driven changes.
5. Spatial impossibilities.

The first prototype can use observation and one small environmental transition. Avoid opaque puzzle logic with no discoverable clues. Ambiguity about meaning is desirable; arbitrary or unreadable interactions are not.

## 11. Threat and failure

The environment is the threat. The first prototype should not need enemies or combat.

Failure has intentionally unclear consequences in the long-term design. It is not yet decided whether the full game has death, checkpoints, lost progress, or conventional game-over states.

For the prototype, avoid punishing death systems. Use safe resets or restart capability for testing. Do not present a restart mechanic as established canon.

## 12. Narrative and unreliable narration

The protagonist's narration or interpretation may contradict the environment.

Guidelines:
- Use narration sparingly because deep silence is a core pillar.
- Prefer a specific discrepancy with meaning over constant vague ominous dialogue.
- Do not tell the player every detail they can already observe.
- Do not reveal the complete explanation in the first prototype.
- Distinguish authored ambiguity from confusing implementation.

Long-term story may include memories, voices, audio fragments, environmental evidence, and surreal scenes. Specific content remains unapproved.

## 13. Audio direction

Primary direction: deep, uncomfortable silence.

Use:
- Footsteps and surface-dependent footstep sound if practical.
- Quiet room tone or ventilation hum when appropriate.
- Sparse distant sounds with careful spatial placement.
- Silence or reduced ambience at deliberate moments.
- Sound transitions tied to environmental state when justified.

Avoid:
- Continuous dramatic music.
- Random loud noises used as a substitute for atmosphere.
- Constant whispers or voices.
- Excessive reverb on every sound.
- Sound that reveals an event before the environment can support it, unless intentional.

Audio should be tested at actual gameplay volume. A sound file existing in the project is not proof that the mix is effective.

## 14. Visual direction

Primary direction: dreamlike liminal aesthetic.

Potential characteristics:
- Washed-out or restrained color.
- Familiar architectural forms.
- Repetition and negative space.
- Carefully composed sightlines.
- Unusual but controlled proportions.
- Subtle lighting inconsistencies.
- Minimal visual clutter.
- Deliberate use of shadow and empty space.

Exact palette, rendering pipeline, texture style, asset source, and fidelity are open. Inspect the current project and available hardware before selecting expensive rendering features.

Avoid relying on darkness alone. Players should be able to read the environment and notice details.

## 15. First prototype — The Silent Place

### Purpose
Validate whether a small first-person liminal environment can create tension through silence, composition, and a meaningful environmental change.

### Proposed experience
1. The player enters an ordinary, empty liminal space.
2. They move through a corridor into a waiting room or similarly restrained environment.
3. Footsteps and subtle room tone establish the space.
4. The player revisits a familiar location.
5. One small but unmistakable detail has changed.
6. A later return reveals a more consequential change in a door, room connection, or layout.
7. The experience ends on an ambiguous environmental moment that suggests the protagonist has been here before.

This is a proposed prototype structure, approved at the concept level. Exact room type and implementation can be adapted to existing project assets and technical constraints.

### Prototype must include
- A functioning first-person controller.
- Collision and stable movement.
- One small, authored environment.
- Several connected spaces or a repeatable route.
- Thoughtful lighting and materials.
- A restrained soundscape.
- At least one repeatable, authored environmental transformation.
- A clear way to start and repeat the experience.
- A test plan and a short end-state/reveal.
- Basic debugging/logging and documented controls.

### Prototype must not require
- Full procedural generation.
- A large open world.
- Enemies or combat.
- A full inventory.
- Extensive dialogue or voice acting.
- Several hours of content.
- Multiple complete endings.
- A definitive explanation of the protagonist's past.
- Complex save/checkpoint systems unless the existing project already has them and they are needed.

## 16. Technical architecture principles

Use Godot 4 and GDScript unless the repository demonstrates an established alternative.

Prioritize:
- Clear scene ownership.
- Explicit state transitions.
- Reusable environment-state changes.
- Stable node references.
- Tunable parameters.
- Testable interactions.
- Small, coherent scripts.
- Existing project conventions.
- Safe collaboration through Git.

Potential systems, only when justified:
- Player controller and camera.
- Interaction detector/lifecycle.
- Environment-state coordinator.
- Memory/discovery trigger.
- Door or route connection state.
- Ambience/audio controller.
- Minimal narration event system.
- Debug controls and test scene.

Avoid creating abstract frameworks for hypothetical future features. Build the smallest architecture that supports the prototype and can be extended cleanly.

## 17. Performance and accessibility

Target hardware and performance goals are not yet specified. Inspect the current development machine and project settings. Use the simplest visual technique that achieves the desired atmosphere.

Avoid:
- Excessive real-time lights and shadows without profiling.
- Unnecessary per-frame allocations.
- Constantly spawning/despawning scene trees for simple state changes.
- Large texture assets without need.
- Unbounded loops or uncontrolled agent task cycles.

Keep controls configurable. Camera effects should not cause unnecessary discomfort. Accessibility options can be planned after the prototype's core interaction is established.

## 18. Long-term direction

The full game may grow to include:
- More varied liminal environments.
- Memory-driven room changes.
- Observation, memory, and spatial puzzles.
- Sparse unreliable narration.
- Audio and interactive memory fragments.
- More consequential player choices.
- Revelations with multiple interpretations.
- Multiple endings or ending variations.

These are long-term directions. They are not promises that all systems must be built before the prototype is evaluated.

## 19. Success criteria for the first prototype

The prototype is technically successful if:
- It launches reliably in the actual project.
- The player can traverse the environment without broken collision or major camera issues.
- The route can be completed and repeated.
- The environmental transformation triggers predictably.
- Scene transitions and object states remain valid.
- Logs and tests do not reveal unresolved critical errors.

The prototype is creatively promising if:
- The environment establishes a coherent baseline before changing.
- The changed detail is discoverable without a loud cue or explicit explanation.
- Silence and sound support the space.
- The world feels deliberately composed rather than randomly assembled.
- The ending creates a question the player wants to think about.

Creative success requires actual playtesting and owner judgment. Do not mark it fully verified based on static checks alone.
