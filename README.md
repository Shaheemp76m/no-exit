# No Exit — Dark Souls-Inspired Horror Game

> A dark, cinematic first-person horror experience built in Godot 4.7.

## Overview

**No Exit** is a Godot 4 horror game prototype. The player starts alone on a solitary dark stone platform suspended under an atmospheric, star-filled night sky with a cinematic, cratered moon inspired by Dark Souls, Bloodborne, and Elden Ring.

## Tech Stack

| Item | Detail |
|------|--------|
| Engine | Godot 4.7.2 (stable) |
| Language | GDScript |
| Physics | Jolt Physics |
| Renderer | GL Compatibility (OpenGL 4.6 / WebGL 2) |

## Project Structure

```
no-exit/
├── project.godot                          # Godot project config (input map, main scene, settings)
├── icon.svg                               # Project icon
├── assets/
│   └── environment/
│       ├── nasa_moon_albedo_2k.jpg        # 2048×1024 NASA LROC global lunar color map
│       ├── nasa_moon_normal.png           # 1024×512 NASA LOLA elevation-derived normal map
│       └── TEXTURE_LICENSES.md            # NASA public domain licensing documentation
├── scenes/
│   ├── main.tscn                          # Root scene — composes platform, night environment, player
│   ├── platform.tscn                      # Square static platform (10×10 units)
│   ├── player.tscn                        # First-person player (inherits player/player.tscn)
│   ├── environment/
│   │   └── night_environment.tscn        # Reusable Souls-like night environment
│   ├── player/
│   │   ├── player.tscn                    # Modular cinematic Soulslike character
│   │   └── assets/
│   │       ├── wanderer_body.tscn         # Visible torso, collar, mantle, belt, and tunic
│   │       ├── wanderer_hand_left.tscn    # Articulated left hand with worn glove & frayed cuff
│   │       ├── wanderer_hand_right.tscn   # Articulated right hand with socket & frayed cuff
│   │       └── wanderer_weapon.tscn       # Weathered medieval steel sword with leather grip
│   ├── interactions/
│   │   └── interactive_door.tscn          # Medieval wooden door with iron bands & hinge physics
│   └── test/
│       └── character_test_room.tscn       # Test arena with narrow corridor, door, ledges, and hazards
├── scripts/
│   ├── player/
│   │   ├── player.gd                      # Main player coordinator and HUD manager
│   │   └── components/
│   │       ├── movement_component.gd      # Walk, run, sprint, inertia, jump & landing impacts
│   │       ├── camera_component.gd        # Mouse look, breathing sway, head bob, turn roll & shock
│   │       ├── procedural_animation_component.gd # Arm sway, momentum lag, wall avoidance & bracing
│   │       ├── weapon_component.gd        # Smooth draw/sheathe transitions and grip poses
│   │       ├── interaction_component.gd   # Raycast detection, prompt triggers & reaching
│   │       ├── damage_reaction_component.gd # Directional hit recoil, flinch & trauma
│   │       └── hand_rig.gd                # Procedural finger articulation and pose blending
│   ├── interactions/
│   │   ├── interactable.gd                # Base class for interactable world objects
│   │   └── door_interactable.gd           # Medieval swinging door logic
│   └── test/
│       ├── damage_zone.gd                 # Contact hazard zone applying directional damage
│       └── test_character_visuals.gd      # Headless / visual automated verification script
└── shaders/
    ├── soulslike_sky.gdshader             # Procedural celestial gradient + 3D isotropic starfield
    ├── moon_surface.gdshader              # Lunar texture, limb darkening, and Fresnel rim
    └── moon_halo.gdshader                 # Billboarded additive atmospheric moon halo
```

## Controls

| Key | Action |
|-----|--------|
| W / A / S / D | Move forward / left / back / right (walk/run with inertia) |
| Shift (Hold) | Heavy locomotive sprint |
| Space | Jump / vault |
| F | Toggle weapon (smooth procedural draw/sheathe) |
| E | Context-sensitive interact (reach & open/close door) |
| 1 | Debug light damage (front-left strike & recoil) |
| 2 | Debug heavy damage (front-right strike & stagger) |
| Esc | Toggle mouse capture |

## How to Run

```bash
# Launch default main scene
godot

# Launch the comprehensive character test room
godot scenes/test/character_test_room.tscn

# Open project in Godot editor
godot -e
```

## Character & Combat Systems

- **Component-Based Architecture**: Fully decoupled components (`MovementComponent`, `CameraComponent`, `ProceduralAnimationComponent`, `WeaponComponent`, `InteractionComponent`, `DamageReactionComponent`, `HandRig`) communicating cleanly via Godot 4 signals and typed references.
- **Physical Anatomical Presence**: No floating camera arms. Pitching the camera downward reveals the wanderer's weathered charcoal tunic, folded mantle, shoulders, and worn leather belt with forged iron buckle.
- **Procedural Hands & Finger Articulation**: Procedural finger joints supporting dynamic poses: relaxed wanderer rest, firm sword grip, outstretched interaction reach, flat wall bracing, and defensive flinch.
- **Weighted Locomotion & Landing Impacts**: Realistic acceleration, deceleration curves, and turn inertia. Distinct walk (2.8 m/s), run (4.8 m/s), and sprint (7.2 m/s) cadences. Fall impacts dynamically drive a damped spring camera dip.
- **Wall Avoidance & Proximity Bracing**: Forward raycasts sense nearby walls and obstacles; arms automatically pull inward and the offhand braces against wall surfaces to prevent geometry clipping.
- **Weapon Handling**: 3D medieval iron sword with fuller groove, steel crossguard, and leather grip. Pressing `F` smoothly transitions between sheathed and drawn states with synchronized hand grip poses.
- **Interactive Objects**: Reusable `Interactable` system demonstrated with a heavy medieval door featuring swinging hinge physics and hand reaching.
- **Directional Damage Trauma**: Directional damage jolts the camera opposite the impact vector and causes defensive arm recoil.

## Environment System Features

- **Procedural Night Sky (`soulslike_sky.gdshader`)**: 3-tier celestial gradient (upper midnight-navy, mid violet-blue, desaturated horizon), 3D isotropic starfield with zero polar distortion, power-law star magnitudes, restrained twinkling, and decoupled radiance calculation.
- **3D Cinematic Moon (`moon_surface.gdshader`)**: 3D SphereMesh offset in upper sky with lunar maria, impact craters, limb darkening, and silver-blue rim.
- **Atmospheric Halo (`moon_halo.gdshader`)**: Camera-billboarded additive halo with exponential radial decay.
- **Moonlight & Lantern**: Directional silver moonlight combined with the wanderer's atmospheric belt lantern and medieval torch braziers.

