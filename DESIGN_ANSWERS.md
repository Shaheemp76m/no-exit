# No Exit — Owner-Confirmed Design Answers

**Status:** All 20 discovery questions answered. The owner approved the consolidated game vision and the proposed first prototype, **The Silent Place**.

This file preserves the answers in order. Do not silently reinterpret them. If a later decision changes one, add a dated decision record and update the canonical design.

## The 20 answers

### Question 1 — Starting concept
**Answer:** Psychological horror.  
**Implication:** The game should focus on uncertainty, atmosphere, perception, and psychological unease rather than conventional action horror.

### Question 2 — Main source of horror
**Answer:** Existential dread.  
**Implication:** Isolation, repetition, identity uncertainty, the apparent impossibility of escape, and questions about the nature of reality should be central.

### Question 3 — Overall setting
**Answer:** Liminal world.  
**Correction history:** The answer was initially recorded as an isolated place, but the owner explicitly corrected it to “D. Liminal world.” The corrected answer is authoritative.  
**Implication:** The setting can move between empty, familiar-but-wrong spaces rather than remaining in one ordinary isolated location.

### Question 4 — Dominant liminal environments
**Answer:** A mixture of liminal environments.  
**Implication:** Corridors, empty public spaces, streets, waiting areas, and impossible architecture may coexist. Introduce them deliberately rather than building a huge world immediately.

### Question 5 — Camera perspective
**Answer:** First-person.  
**Implication:** The player experiences the world through the protagonist's eyes. Camera motion should be comfortable and intentional; hands/body visibility is not yet a confirmed requirement.

### Question 6 — Protagonist
**Answer:** Someone who has been here before.  
**Implication:** The protagonist recognizes fragments of places or experiences but cannot initially explain why. Their past is an open mystery, not yet a defined backstory.

### Question 7 — Behavior when revisiting locations
**Answer:** Memory-driven changes.  
**Implication:** Environment changes should be causally connected to memory discoveries or narrative state, not merely random rearrangements.

### Question 8 — Memory revelation
**Answer:** A combination of environmental storytelling, interactive memory fragments, audio/voices, and surreal dream sequences.  
**Implication:** These are long-term storytelling channels. The first prototype only needs a small environmental hint; it does not need all four systems implemented in full.

### Question 9 — Core gameplay loop
**Answer:** Experience a psychological journey.  
**Implication:** Exploration and interpretation take priority over combat or score-driven gameplay.

### Question 10 — Role of danger
**Answer:** The environment itself is the threat.  
**Implication:** No conventional enemy is required for the first prototype. Architecture, isolation, uncertainty, and world changes should generate tension.

### Question 11 — Sound direction
**Answer:** Deep, uncomfortable silence.  
**Implication:** Use restrained room tone, footsteps, and occasional distant environmental sounds. Do not fill every moment with music or effects.

### Question 12 — Visual direction
**Answer:** Dreamlike liminal aesthetic.  
**Implication:** Familiar spaces, washed-out or restrained colors, repeating forms, unusual proportions, and subtle impossibilities. Specific palette and rendering technique remain open.

### Question 13 — Exploration and interaction
**Answer:** A combination of physical and immersive interaction, simple interaction actions, environmental manipulation, and observation.  
**Implication:** Use the simplest interaction that supports the moment. Reserve detailed interactions for meaningful objects; do not overbuild a universal interaction framework before it is needed.

### Question 14 — Puzzle design
**Answer:** A layered combination. Start with subtle observations and gradually introduce memory-driven and spatial puzzles.  
**Implication:** Puzzle complexity should escalate through the game. The first prototype can use a simple observational inconsistency, not a full puzzle campaign.

### Question 15 — Failure
**Answer:** Unclear consequences.  
**Implication:** Players may not immediately know whether an event was a mistake, a progression trigger, or a change in the world. Death, checkpoint loss, and conventional game-over rules remain undecided.

### Question 16 — World structure
**Answer:** Dynamically rearranged world.  
**Implication:** Room appearance and connectivity may change. For the prototype, prefer authored, deterministic transitions over expensive general-purpose procedural generation.

### Question 17 — Storytelling
**Answer:** Unreliable narration.  
**Implication:** Narration or the protagonist's interpretation may contradict visible events. Because silence is central, narration should be sparse and purposeful.

### Question 18 — Ending structure
**Answer:** A combination of revelations, meaningful choices, and ambiguity.  
**Implication:** This is a long-term narrative direction. Multiple endings and the exact final revelation are not required for the first prototype.

### Question 19 — Project scope
**Answer:** Experimental prototype first.  
**Implication:** Prioritize one polished, playable vertical slice and learn from it before committing to a full game scope.

### Question 20 — First prototype focus
**Answer:** Liminal atmosphere.  
**Implication:** The first playable slice should prove that the environment, lighting, sound, scale, composition, and a small unsettling change can create tension without enemies or jump scares.

## Approved summary

The owner approved this summary:

> No Exit is a first-person existential horror game in which a silent, dreamlike liminal world changes around a protagonist who has been there before, using memory, impossible architecture, and unreliable narration to make escape and reality itself uncertain.

## Approved first prototype

**Name:** The Silent Place  
**Primary goal:** Prove the liminal atmosphere and basic environmental transformation in a small, repeatable, playable first-person experience.

## Decisions still open

These are intentionally unresolved and must not be fabricated:
- Protagonist name, identity, biography, and ultimate truth.
- Exact setting and reason the protagonist has returned.
- Specific narrative events and meaning of memories.
- Exact movement speed, acceleration, jump capability, and camera effects.
- Whether jumping is available at all.
- Exact interaction key and UI presentation.
- Specific palette, rendering pipeline, target visual fidelity, and asset style.
- Whether the player can die or lose progress.
- Save/checkpoint rules.
- Final game duration and release model.
- Exact ending count and conditions.
- Target hardware and performance target.
- Whether body/hands are visible in first person.
- Whether the game uses voice acting or text-only narration.
- Specific content boundaries and accessibility requirements.

## Decision-change policy

If the owner changes a confirmed answer:
1. Preserve the previous decision in a dated entry in `DECISIONS_LOG.md`.
2. Update this file and `GAME_DESIGN.md`.
3. Check consequences for roadmap, task dependencies, and tests.
4. Do not silently reinterpret the previous answer.
