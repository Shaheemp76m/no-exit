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

### Full Source

```gdscript
extends CharacterBody3D

const SPEED = 5.0
const SENSITIVITY = 0.003
const JUMP_VELOCITY = 4.5

var mouse_locked = true
var pitch = 0.0

@onready var camera: Camera3D = $Camera3D

func _ready() -> void:
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseMotion and mouse_locked:
        rotate_y(-event.relative.x * SENSITIVITY)
        pitch = clamp(pitch - event.relative.y * SENSITIVITY, -1.4, 1.4)
        camera.rotation.x = pitch

    if event is InputEventKey and event.pressed:
        if event.keycode == KEY_ESCAPE:
            mouse_locked = not mouse_locked
            Input.set_mouse_mode(
                Input.MOUSE_MODE_CAPTURED if mouse_locked else Input.MOUSE_MODE_VISIBLE
            )

func _physics_process(delta: float) -> void:
    if not is_on_floor():
        velocity.y -= ProjectSettings.get_setting("physics/3d/default_gravity") * delta

    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = JUMP_VELOCITY

    var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
    var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

    velocity.x = direction.x * SPEED
    velocity.z = direction.z * SPEED

    move_and_slide()
```
