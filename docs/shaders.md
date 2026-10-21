# Shaders Reference

All shaders live in `res://shaders/`.

---

## `star_sky.shader`

**Type:** `shader_type sky`  
**Status:** ✅ Authored — not yet assigned to the sky material (pending integration)

A procedural sky shader that generates a **twinkling star field** over a dark night background. Designed to replace or complement the built-in `ProceduralSkyMaterial` used in `sky.tscn`.

---

### Uniforms

| Uniform | Type | Default | Description |
|---------|------|---------|-------------|
| `star_density` | `float` | `0.001` | Probability per pixel of being a star. Increase for more stars. |
| `star_color` | `vec3` | `vec3(1.0)` — white | Base colour of the stars |
| `star_size` | `float` | `0.5` | Reserved for future size variation |
| `twinkle_speed` | `float` | `2.0` | Speed of the twinkling animation (uses `TIME`) |

---

### How It Works

1. **Background** — sets `ALBEDO` to a near-black dark blue (`vec3(0, 0, 0.05)`).
2. **Star generation** — uses a `fract(sin(dot(UV, ...)) * large_number)` hash to produce a pseudo-random value per UV position.
3. **Threshold** — if the random value is below `star_density`, that pixel is a star.
4. **Twinkle** — brightness is modulated by a sine wave driven by `TIME` and the star's unique random seed, making each star pulse at a slightly different phase.

---

### How to Apply

1. Open `sky.tscn` in the Godot editor.
2. Select the `WorldEnvironment` node.
3. In the `Environment` resource, expand **Sky → Sky Material**.
4. Change the material type from `ProceduralSkyMaterial` to `ShaderMaterial`.
5. Assign `res://shaders/star_sky.shader` as the shader.
6. Tune the uniforms (`star_density`, `twinkle_speed`) in the Inspector.

> [!TIP]
> Start with `star_density = 0.001` and increase gradually. Values above `0.01` will make the sky look very crowded.

---

### Full Source

```glsl
shader_type sky;

uniform float star_density = 0.001;
uniform vec3 star_color = vec3(1.0);
uniform float star_size = 0.5;
uniform float twinkle_speed = 2.0;

void fragment(){
    // Base dark background
    ALBEDO = vec3(0.0, 0.0, 0.05);

    // Random star field using UV coordinates
    float rnd = fract(sin(dot(UV, vec2(12.9898, 78.233))) * 43758.5453);
    if (rnd < star_density) {
        float twinkle = sin(TIME * twinkle_speed + rnd * 6.2831) * 0.5 + 0.5;
        ALBEDO = mix(ALBEDO, star_color, twinkle);
    }
}
```
