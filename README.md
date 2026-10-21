# No Exit — Horror Game

> A minimalist first-person horror experience built in Godot 4.7.

## Overview

**No Exit** is a Godot 4 horror game. The player starts alone on a small dark platform suspended under a vast, star-filled night sky. The goal is to build an atmosphere of dread through isolation, limited visibility, and eerie ambience.

## Tech Stack

| Item | Detail |
|------|--------|
| Engine | Godot 4.7.2 (Forward+) |
| Language | GDScript |
| Physics | Jolt Physics |
| Renderer | Forward Plus (Vulkan) |

## Project Structure

```
no-exit/
├── project.godot              # Godot project config (input map, main scene, settings)
├── icon.svg                   # Project icon
├── scenes/
│   ├── main.tscn              # Root scene — composes platform, sky, player
│   ├── platform.tscn          # Square static platform
│   ├── sky.tscn               # WorldEnvironment (night sky + fog)
│   └── player.tscn            # First-person player (CharacterBody3D)
├── scripts/
│   └── player_controller.gd   # WASD movement + mouse look
└── shaders/
    └── star_sky.shader        # Procedural twinkling-star sky shader (future use)
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
# Open the editor
godot --path /home/ross/projects/gameathon/godot/no-exit

# Or run headless (testing)
godot --headless --path /home/ross/projects/gameathon/godot/no-exit res://scenes/main.tscn --quit-after 60
```

## Roadmap

- [x] Square platform to stand on  
- [x] Starry night sky with fog  
- [x] First-person movement (WASD + mouse look + jump)  
- [ ] Procedural star shader applied to sky  
- [ ] Ambient horror audio (hum, wind, distant sounds)  
- [ ] Horror events / encounters  
- [ ] Inventory / interaction system  
- [ ] Main menu & settings screen  
