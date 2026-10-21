# Scene Reference

All scenes live in `res://scenes/`. Each scene is self-contained and gets instanced into `main.tscn`.

---

## `main.tscn`

**Root scene** — the entry point of the game.

### Node Tree
```
Main (Node3D)
├── NightEnvironment → instance of scenes/environment/night_environment.tscn
├── Platform         → instance of scenes/platform.tscn
└── Player           → instance of scenes/player.tscn (spawned at Y=2 above platform)
```

### Notes
- Set as the main scene via `run/main_scene` in `project.godot`.
- Player is offset `Transform3D(..., 0, 2, 0)` so they start above the platform and fall onto it at runtime.

---

## `night_environment.tscn`

A comprehensive, reusable **Souls-like night environment** containing the procedural celestial sky, realistic cratered 3D moon, atmospheric halo, soft directional moonlight, and calibrated WorldEnvironment.

### Node Tree
```
NightEnvironment (Node3D)
├── WorldEnvironment      — Environment with soulslike_sky.gdshader, filmic tonemapping, glow, fog
├── Moon (MeshInstance3D) — 3D SphereMesh (radius 6.5, height 13.0) with moon_surface.gdshader
│   └── MoonHalo          — QuadMesh (30×30) with camera-billboarding moon_halo.gdshader
└── MoonLight             — DirectionalLight3D casting soft silver moonlight from moon's position
```

### Components & Visual Features
- **WorldEnvironment**: Sky background mode with custom sky shader, cool low-intensity ambient light (`Color(0.025, 0.035, 0.065)`), Filmic tonemapper, subtle glow/bloom, and distance fog.
- **Moon**: Placed in upper-left sky `(-45, 38, -100)` for cinematic rule-of-thirds composition. Uses `moon_albedo.png` and procedural surface shader with limb darkening.
- **MoonHalo**: Soft additive radial atmospheric glow around lunar perimeter.
- **MoonLight**: Soft directional moonlight (`Color(0.68, 0.74, 0.88)`, energy `0.28`) casting shadows towards the scene center.

---

## `platform.tscn`

A **static square platform** the player stands on.

### Node Tree
```
Platform (StaticBody3D)
├── MeshInstance3D   — PlaneMesh (10×10 units), dark StandardMaterial3D
└── CollisionShape3D — BoxShape3D (10×0.1×10 units)
```

### Properties
| Property | Value |
|----------|-------|
| Mesh size | `Vector2(10, 10)` |
| Collision size | `Vector3(10, 0.1, 10)` |
| Material albedo | `Color(0.05, 0.05, 0.07, 1.0)` |
| Roughness | `0.8` |
| Metallic | `0.0` |

---

## `sky.tscn`

Sets up the **night sky and fog atmosphere** using a `WorldEnvironment` node.

### Node Tree
```
WorldEnvironment
└── environment (Environment resource)
    └── sky (Sky resource)
        └── sky_material (ProceduralSkyMaterial)
```

### Sky Colors
| Property | Value |
|----------|-------|
| Sky top color | `Color(0.0, 0.0, 0.02, 1.0)` — near black |
| Sky horizon color | `Color(0.01, 0.01, 0.02, 1.0)` |
| Ground horizon | `Color(0.01, 0.01, 0.02, 1.0)` |
| Ground bottom | `Color(0.0, 0.0, 0.0, 1.0)` — pure black |

### Fog
| Property | Value |
|----------|-------|
| Fog enabled | `true` |
| Fog color | `Color(0.02, 0.02, 0.04, 1.0)` |
| Fog density | `0.01` |

### Ambient Light
| Property | Value |
|----------|-------|
| Ambient light color | `Color(0.05, 0.05, 0.08, 1.0)` |
| Ambient light energy | `0.5` |

> [!NOTE]
> A custom procedural **star shader** (`res://shaders/star_sky.shader`) has been authored and is ready to be assigned to the sky material for a more detailed star field.

---

## `player.tscn`

The **first-person player controller**.

### Node Tree
```
Player (CharacterBody3D)
├── Camera3D              — current=true, height Y=1.6 (eye level)
└── CollisionShape3D      — CapsuleShape3D (radius=0.5, height=1.8)
```

### Script
Attached script: [`res://scripts/player_controller.gd`](../scripts/player_controller.gd)

### Key Settings
| Property | Value |
|----------|-------|
| Camera Y offset | `1.6` (eye level) |
| Capsule radius | `0.5` |
| Capsule height | `1.8` |
