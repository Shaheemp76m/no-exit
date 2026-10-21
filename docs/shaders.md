# Shaders Reference

All shaders live in `res://shaders/`.

---

## 1. `soulslike_sky.gdshader`

**Type:** `shader_type sky`  
**Location:** [`res://shaders/soulslike_sky.gdshader`](../shaders/soulslike_sky.gdshader)  
**Status:** ✅ Active in `scenes/environment/night_environment.tscn`

A cinematic Dark Souls-inspired procedural night sky shader providing a deep midnight atmosphere, an isotropic 3D cellular starfield, and decoupled radiance calculation.

### Uniform Groups & Parameters

#### `Sky_Palette`
| Uniform | Type | Default | Description |
|---------|------|---------|-------------|
| `upper_sky_color` | `vec3` (source_color) | `(0.012, 0.016, 0.034)` | Deep, nearly black navy at the celestial zenith |
| `mid_sky_color` | `vec3` (source_color) | `(0.025, 0.032, 0.058)` | Muted midnight-blue with violet undertones |
| `horizon_color` | `vec3` (source_color) | `(0.055, 0.065, 0.090)` | Lighter, desaturated misty slate at the horizon |
| `ground_color` | `vec3` (source_color) | `(0.005, 0.006, 0.010)` | Dark abyss gradient below the horizon line |

#### `Gradient_Controls`
| Uniform | Type | Default | Description |
|---------|------|---------|-------------|
| `gradient_height` | `float` (0.1–2.0) | `0.65` | Vertical transition height of the horizon blend |
| `gradient_intensity` | `float` (0.1–3.0) | `1.15` | Falloff curve exponent of the celestial gradient |

#### `Star_Field`
| Uniform | Type | Default | Description |
|---------|------|---------|-------------|
| `star_density` | `float` (50–400) | `220.0` | Frequency of the 3D celestial star grid |
| `star_brightness` | `float` (0.1–4.0) | `1.6` | Overall magnitude multiplier of the starfield |
| `twinkle_intensity` | `float` (0.0–1.0) | `0.4` | Amplitude of brightness pulsing on prominent stars |
| `twinkle_speed` | `float` (0.1–5.0) | `1.8` | Speed of the sinusoidal twinkle cycle |

#### `Atmosphere`
| Uniform | Type | Default | Description |
|---------|------|---------|-------------|
| `haze_intensity` | `float` (0.0–1.0) | `0.18` | Subdued cosmic dust / nebula haze strength |

### Architecture Highlights
- **No Polar Distortion**: Uses a 3D cellular grid derived from `EYEDIR` rather than 2D UV mapping. Stars are uniformly isotropic everywhere.
- **Astronomical Magnitude Distribution**: Star brightness uses a steep power-law (`pow(rnd.z, 3.5)`), ensuring ~85% of stars are faint, distant pinpricks while ~15% form prominent landmark stars.
- **Decoupled Radiance**: The animated twinkle effect checks `if (!AT_CUBEMAP_PASS)`. During environment radiance cubemap rendering, twinkle is bypassed, preventing expensive per-frame cubemap re-renderings.

---

## 2. `moon_surface.gdshader`

**Type:** `shader_type spatial`  
**Render Mode:** `unshaded, blend_mix, depth_draw_opaque, cull_back`  
**Location:** [`res://shaders/moon_surface.gdshader`](../shaders/moon_surface.gdshader)  
**Status:** ✅ Active on `Moon` mesh in `scenes/environment/night_environment.tscn`

Maps a 2048×1024 NASA Lunar Reconnaissance Orbiter (LROC) albedo texture and LOLA elevation-derived normal map onto a 3D `SphereMesh`. Features Lommel-Seeliger porous regolith scattering, subtle crater rim highlights, astronomical limb-darkening, and a delicate silver-blue Fresnel rim glow.

### Uniforms

| Uniform | Type | Default | Description |
|---------|------|---------|-------------|
| `albedo_texture` | `sampler2D` | `nasa_moon_albedo_2k.jpg` | 2048×1024 NASA LROC global lunar color mosaic |
| `normal_map` | `sampler2D` | `nasa_moon_normal.png` | 1024×512 NASA LOLA laser altimeter derived normal map |
| `normal_depth` | `float` (0.0–3.0) | `1.1` | Crater relief and depth multiplier |
| `moon_tint` | `vec3` (source_color) | `(0.86, 0.90, 0.96)` | Pale silvery-blue cinematic color grading |
| `brightness` | `float` (0.1–3.0) | `1.18` | Self-illumination strength |
| `contrast` | `float` (0.5–2.0) | `1.08` | Contrast between basaltic maria and anorthosite highlands |
| `ambient_fill` | `float` (0.1–1.0) | `0.78` | Soft ambient fill preventing pitch-black shadows on dark crater floors |
| `rough_highlight` | `float` (0.0–1.0) | `0.12` | Restrained cool rough highlight on crater rims |
| `sun_direction` | `vec3` | `(0.35, 0.25, 0.90)` | Oblique solar angle illuminating crater topography |
| `limb_exponent` | `float` (0.5–4.0) | `1.4` | Astronomical limb darkening exponent |
| `rim_glow_color` | `vec3` (source_color) | `(0.60, 0.72, 0.90)` | Color of the delicate atmospheric Fresnel edge |
| `rim_glow_intensity` | `float` (0.0–1.0) | `0.24` | Strength of the Fresnel edge rim (keeps surface details crisp) |

---

## 3. `moon_halo.gdshader`

**Type:** `shader_type spatial`  
**Render Mode:** `unshaded, blend_add, depth_draw_never, cull_disabled, shadows_disabled`  
**Location:** [`res://shaders/moon_halo.gdshader`](../shaders/moon_halo.gdshader)  
**Status:** ✅ Active on `MoonHalo` quad in `scenes/environment/night_environment.tscn`

A camera-billboarded additive quad rendering a soft, ethereal atmospheric aura around the moon that decays smoothly into the night sky.

### Uniforms

| Uniform | Type | Default | Description |
|---------|------|---------|-------------|
| `halo_color` | `vec3` (source_color) | `(0.55, 0.68, 0.88)` | Soft silver-cyan ethereal glow color |
| `halo_intensity` | `float` (0.0–3.0) | `0.85` | Peak additive brightness at the lunar limb |
| `halo_falloff` | `float` (1.0–15.0) | `3.5` | Exponential decay rate into the surrounding sky |
