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


## `player.tscn`

The **first-person player controller** — inherits from [`res://scenes/player/player.tscn`](file:///home/ross/projects/gameathon/godot/no-exit/scenes/player/player.tscn) ensuring backward compatibility while running the full modular architecture.

---

## `player/player.tscn`

The **modular cinematic Soulslike player character**.

### Node Tree
```
Player (CharacterBody3D, script: player.gd)
├── CollisionShape3D (CapsuleShape3D, radius=0.45, height=1.8)
├── MovementComponent (Node, script: movement_component.gd)
├── DamageReactionComponent (Node, script: damage_reaction_component.gd)
├── BeltLantern (OmniLight3D, warm amber fill at waist)
├── WandererBody (instance of scenes/player/assets/wanderer_body.tscn)
├── CameraComponent (Node3D, script: camera_component.gd)
│   ├── Camera3D (Camera3D, current=true, near=0.05, fov=75)
│   ├── InteractionComponent (Node3D, script: interaction_component.gd)
│   │   └── RayCast3D (target_position=(0, 0, -2.5), areas=true)
│   └── ProceduralAnimationComponent (Node3D, script: procedural_animation_component.gd)
│       ├── WallRayLeft (RayCast3D, left wall sensor)
│       ├── WallRayRight (RayCast3D, right wall sensor)
│       ├── LeftArmPivot (Node3D)
│       │   └── WandererHandLeft (instance of wanderer_hand_left.tscn)
│       └── RightArmPivot (Node3D)
│           └── WandererHandRight (instance of wanderer_hand_right.tscn)
│               └── WeaponSocket
│                   └── WeaponComponent (Node3D, script: weapon_component.gd)
│                       └── WeaponMesh (instance of wanderer_weapon.tscn)
└── HUD (CanvasLayer)
    ├── Reticle (Center target dot)
    ├── PromptLabel (Contextual interaction prompt)
    └── StatusLabel (HP, movement state, weapon state, controls guide)
```

---

## `player/assets/`

- **`wanderer_body.tscn`**: Worn medieval mantle, folded tunic, waist belt, and forged iron buckle. Visually positioned so looking down frames the chest without camera clipping.
- **`wanderer_hand_left.tscn`**: Articulated left forearm, frayed cloth cuff, palm, opposable thumb, and four fingers with cracked leather glove material.
- **`wanderer_hand_right.tscn`**: Articulated right hand containing the `WeaponSocket` node for dynamic sword attachment.
- **`wanderer_weapon.tscn`**: Weathered medieval steel sword with fuller groove, steel crossguard, wrapped leather grip, and counterweight pommel.

---

## `interactions/interactive_door.tscn`

A heavy medieval wooden door with iron reinforcing bands, stone archway pillars, handle, and an `AnimatableBody3D` door leaf pivoted along a hinge. Interacting swings the door open 95 degrees with hinge smoothing and updates prompts dynamically.

---

## `test/character_test_room.tscn`

A dedicated testing arena set under the night sky featuring:
- Narrow corridor with stone walls for testing wall avoidance and hand bracing.
- Interactive medieval door at the corridor exit.
- Stone stairs and elevated 2.5m drop ledge for testing vertical locomotion and landing impacts.
- Cursed rune damage zone for testing directional damage, camera shock, and flinch recoil.
- Warm medieval braziers and torchlight.

