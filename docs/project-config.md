# Project Configuration

File: `project.godot`

This is the Godot 4 project config file. Below is a breakdown of every section.

---

## `[application]`

| Key | Value | Description |
|-----|-------|-------------|
| `config/name` | `"no exit"` | Project name shown in the editor |
| `config/features` | `["4.7", "GL Compatibility"]` | Godot version and compatibility renderer |
| `config/icon` | `res://icon.svg` | Project icon |
| `run/main_scene` | `res://scenes/main.tscn` | Scene that launches on Play (F5) |

---

## `[display]`

| Key | Value | Description |
|-----|-------|-------------|
| `window/stretch/mode` | `canvas_items` | Scales UI elements with window size |
| `window/stretch/aspect` | `expand` | Allows the viewport to expand to fill window |

---

## `[physics]`

| Key | Value | Description |
|-----|-------|-------------|
| `3d/physics_engine` | `Jolt Physics` | Uses the Jolt physics engine (better perf than GodotPhysics) |

---

## `[rendering]`

| Key | Value | Description |
|-----|-------|-------------|
| `rendering_device/driver.windows` | `d3d12` | Windows-only: uses Direct3D 12 backend |

---

## `[input]`

All custom input actions. These are mapped to physical keyboard keys.

| Action | Key | Physical Keycode |
|--------|-----|-----------------|
| `move_forward` | W | 87 |
| `move_back` | S | 83 |
| `move_left` | A | 65 |
| `move_right` | D | 68 |
| `jump` | Space | 32 |

> [!NOTE]
> `physical_keycode` is used so keybindings work correctly regardless of keyboard layout (e.g., AZERTY vs QWERTY).

> [!WARNING]
> Do not manually edit the `[input]` section if you can avoid it — use the **Project Settings → Input Map** UI in the Godot editor instead to avoid formatting mistakes.
