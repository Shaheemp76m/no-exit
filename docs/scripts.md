# Scripts Reference

All scripts live in `res://scripts/`.

---

## `player_controller.gd`

**Attached to:** `Player` (`CharacterBody3D`) in `player.tscn`

Handles all first-person movement, camera look, jumping, and mouse capture.

---

### Constants

| Constant | Value | Description |
|----------|-------|-------------|
| `SPEED` | `5.0` | Movement speed in units/sec |
| `SENSITIVITY` | `0.003` | Mouse look sensitivity |
| `JUMP_VELOCITY` | `4.5` | Upward velocity applied on jump |

### Variables

| Variable | Type | Description |
|----------|------|-------------|
| `mouse_locked` | `bool` | Whether the mouse is captured (`true` = captured) |
| `pitch` | `float` | Current vertical camera angle (clamped ±1.4 rad) |
| `camera` | `Camera3D` | Reference to `$Camera3D` (via `@onready`) |

---

### Functions

#### `_ready() -> void`
- Captures the mouse cursor on scene start (`MOUSE_MODE_CAPTURED`).

#### `_unhandled_input(event: InputEvent) -> void`
- **Mouse motion**: Rotates the player body on the Y‑axis (horizontal look) and rotates the camera on the X‑axis (vertical look / pitch), clamped to ±1.4 radians to prevent flipping.
- **Escape key**: Toggles mouse capture on/off for debugging.

#### `_physics_process(delta: float) -> void`
1. **Gravity** — applies `physics/3d/default_gravity` downward every frame when not on the floor.
2. **Jump** — applies `JUMP_VELOCITY` upward when `jump` action is pressed and player is on the floor.
3. **Movement** — reads `move_left/right/forward/back` input via `Input.get_vector()`, maps it to a world‑space direction using the player's `transform.basis`, and sets `velocity.x/z`.
4. Calls `move_and_slide()` to apply physics movement.

---

### Input Actions (defined in `project.godot`)

| Action | Key | Physical Keycode |
|--------|-----|-----------------|
| `move_forward` | W | 87 |
| `move_back` | S | 83 |
| `move_left` | A | 65 |
| `move_right` | D | 68 |
| `jump` | Space | 32 |

---

## `scripts/player/player.gd`

**Main coordinator** for the modular first-person character.
- Collects raw inputs (WASD, Sprint, Jump, Weapon Toggle, Interact, Debug Damage).
- Delegates movement simulation to `MovementComponent`.
- Updates `CameraComponent` (breathing sway, head bob, turn roll, landing shock).
- Updates `ProceduralAnimationComponent` (arm swinging, mouse lag, wall avoidance).
- Updates `WeaponComponent` (state transitions and grip poses).
- Updates `InteractionComponent` (raycasts and reaching).
- Updates HUD status overlay.

---

## `scripts/player/components/movement_component.gd`

- Manages weighted Soulslike locomotion states: `IDLE`, `WALK` (2.8 m/s), `RUN` (4.8 m/s), `SPRINT` (7.2 m/s), `AIR`.
- Employs ground acceleration (`12.0`) and friction (`14.0`) curves providing tangible weight.
- Detects floor landing impacts and emits `landed(impact_velocity: float)`.

---

## `scripts/player/components/camera_component.gd`

- Handles mouse pitch/yaw with clamped angles.
- Simulates organic exhausted breathing sway modulated by movement state.
- Dynamic head bobbing along a figure-8 path.
- Damped harmonic spring simulation for landing dips.
- Directional camera jolts on damage.

---

## `scripts/player/components/procedural_animation_component.gd`

- Animates left and right arm pivots procedurally.
- Senses nearby obstacles with forward raycasts (`WallRayLeft`, `WallRayRight`).
- Smoothly pulls hands inward and postures the offhand into `WALL_BRACE` when close to walls.
- Simulates mouse rotation lag and weapon guard stances.

---

## `scripts/player/components/hand_rig.gd`

- Controls articulated finger joints: thumb, index, middle, ring, pinky.
- Supports programmatic poses:
  - `REST`: Relaxed asymmetrical wanderer posture.
  - `GRIP`: Clenched fist wrapping the sword hilt.
  - `REACH`: Outstretched fingers for doors and levers.
  - `WALL_BRACE`: Splayed palm bracing against surfaces.
  - `FLINCH`: Tensed defensive curl on impact.

---

## `scripts/player/components/weapon_component.gd`

- Manages weapon states: `SHEATHED`, `DRAWING`, `DRAWN`, `SHEATHING`.
- Connects to `HandRig` to synchronize finger curl with draw/sheathe transitions.
- Smoothly moves weapon between hip sheathed position and hand grasp.

---

## `scripts/player/components/interaction_component.gd`

- Raycasts forward up to 2.5m for `Interactable` colliders.
- Triggers contextual HUD prompts (e.g. `[E] Open Door`).
- Drives the wanderer's left hand to reach forward during interactions.

---

## `scripts/player/components/damage_reaction_component.gd`

- Processes incoming damage vectors and severity (`light` vs `heavy`).
- Directs camera shock and defensive arm recoil.
- Tracks player health.

---

## `scripts/interactions/`

- **`interactable.gd`**: Abstract collision base providing `interact(user)`, `can_interact(user)`, and `get_prompt()`.
- **`door_interactable.gd`**: Medieval swinging door controller with hinge smoothing.

