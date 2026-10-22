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
│   ├── player.tscn                        # First-person player (CharacterBody3D)
│   └── environment/
│       └── night_environment.tscn        # Reusable Souls-like night environment
├── scripts/
│   └── player_controller.gd               # WASD movement, mouse look, jump, cursor toggle
└── shaders/
    ├── soulslike_sky.gdshader             # Procedural celestial gradient + 3D isotropic starfield
    ├── moon_surface.gdshader              # Lunar texture, limb darkening, and Fresnel rim
    └── moon_halo.gdshader                 # Billboarded additive atmospheric moon halo
```

## Controls

| Key | Action |
|-----|--------|
| W / A / S / D | Move forward / left / back / right |
| Mouse | Look around |
| Space | Jump |
| Esc | Toggle mouse capture |

## How to Run

```bash
# Launch game directly
godot

# Open in editor
godot -e
```

## Environment System Features

- **Procedural Night Sky (`soulslike_sky.gdshader`)**: 3-tier celestial gradient (upper midnight-navy, mid violet-blue, desaturated horizon), 3D isotropic starfield with zero polar distortion, power-law star magnitudes, restrained twinkling, and decoupled radiance calculation.
- **3D Cinematic Moon (`moon_surface.gdshader`)**: 3D SphereMesh offset in upper sky with lunar maria, impact craters, limb darkening, and silver-blue rim.
- **Atmospheric Halo (`moon_halo.gdshader`)**: Camera-billboarded additive halo with exponential radial decay.
- **Moonlight (`DirectionalLight3D`)**: Soft directional silver moonlight with shadows directed towards the scene.
- **WorldEnvironment**: Filmic tonemapper, cool ambient light fill, subtle glow/bloom, and distance fog.
