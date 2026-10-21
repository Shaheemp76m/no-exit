# Lunar Texture Sources & Licenses

All environmental textures in `res://assets/environment/` are stored locally within the project. The game has zero runtime network dependencies.

---

## 1. `nasa_moon_albedo_2k.jpg`

- **Description**: Equirectangular global color and albedo mosaic of the Moon.
- **Resolution**: 2048 × 1024 (2K)
- **Source**: NASA Scientific Visualization Studio (SVS Entry 4720: *CGI Moon Kit*, by Ernie Wright, NASA Goddard Space Flight Center).
- **Instruments / Data**: NASA Lunar Reconnaissance Orbiter (LRO) — Lunar Reconnaissance Orbiter Camera (LROC) Wide Angle Camera (WAC) Hapke Normalized Global Mosaic, composited from over 100,000 orbital images. High latitudes augmented with LOLA monochromatic laser reflectance data.
- **URL**: [https://svs.gsfc.nasa.gov/4720/](https://svs.gsfc.nasa.gov/4720/)
- **License**: **Public Domain** (NASA copyright policy: NASA media is not protected by copyright and may be used for educational, informational, and commercial purposes without restriction).

---

## 2. `nasa_moon_elevation.jpg`

- **Description**: Equirectangular global topographic elevation map of the Moon.
- **Resolution**: 1024 × 512
- **Source**: NASA Scientific Visualization Studio (SVS Entry 4720).
- **Instruments / Data**: NASA Lunar Reconnaissance Orbiter (LRO) — Lunar Orbiter Laser Altimeter (LOLA).
- **License**: **Public Domain**.

---

## 3. `nasa_moon_normal.png`

- **Description**: 16-bit equivalent tangent-space normal map derived from NASA LOLA global topographic data to provide physically accurate crater rims, floor shadows, and surface relief.
- **Resolution**: 1024 × 512
- **Source**: Synthesized from `nasa_moon_elevation.jpg` using continuous spherical gradient derivation with seamless longitudinal boundary wrapping.
- **License**: **Public Domain / CC0**.
