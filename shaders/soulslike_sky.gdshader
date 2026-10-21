shader_type sky;

/*
 * Dark Souls-Inspired Procedural Night Sky Shader (Stabilized & Refined)
 * Designed for Godot 4.x (GL Compatibility & Forward+)
 * 
 * Stability & Anti-Aliasing Architecture:
 * - Deterministic celestial sphere projection: each star direction is a fixed unit vector
 * - Integer bitwise hashing prevents floating-point cancellation across camera angles
 * - Anti-aliased Gaussian profile eliminates sub-pixel popping/flickering under rotation
 * - Reduced density, smaller pinprick sizing, and steep power-law magnitude to eliminate noise
 * - Trilinear continuous value noise for ethereal atmospheric haze (no voxel stepping)
 * - Restrained twinkling applied strictly as a scalar multiplier on rare landmark stars
 * - Radiance pass decoupling: dynamic effects bypassed in AT_CUBEMAP_PASS
 */

group_uniforms Sky_Palette;
uniform vec3 upper_sky_color : source_color = vec3(0.012, 0.016, 0.034);
uniform vec3 mid_sky_color : source_color = vec3(0.025, 0.032, 0.058);
uniform vec3 horizon_color : source_color = vec3(0.055, 0.065, 0.090);
uniform vec3 ground_color : source_color = vec3(0.005, 0.006, 0.010);

group_uniforms Gradient_Controls;
uniform float gradient_height : hint_range(0.1, 2.0, 0.05) = 0.65;
uniform float gradient_intensity : hint_range(0.1, 3.0, 0.1) = 1.15;

group_uniforms Star_Field;
uniform float star_density : hint_range(15.0, 80.0, 1.0) = 34.0;
uniform float star_brightness : hint_range(0.1, 4.0, 0.1) = 1.25;
uniform float twinkle_intensity : hint_range(0.0, 1.0, 0.05) = 0.25;
uniform float twinkle_speed : hint_range(0.1, 5.0, 0.1) = 1.4;

group_uniforms Atmosphere;
uniform float haze_intensity : hint_range(0.0, 1.0, 0.02) = 0.14;

// Bitwise 3D integer hash (stable across all platforms, no trig precision loss)
uint hash_uvec3(uvec3 p) {
	p = p * uvec3(73856093u, 19349663u, 83492791u);
	uint h = p.x ^ p.y ^ p.z;
	h = h ^ (h >> 16u);
	h = h * 0x85ebca6bu;
	h = h ^ (h >> 13u);
	h = h * 0xc2b2ae35u;
	h = h ^ (h >> 16u);
	return h;
}

vec4 hash_cell(ivec3 p) {
	uvec3 up = uvec3(p + ivec3(10000));
	uint h1 = hash_uvec3(up);
	uint h2 = hash_uvec3(up + uvec3(11u, 23u, 37u));
	uint h3 = hash_uvec3(up + uvec3(41u, 53u, 67u));
	uint h4 = hash_uvec3(up + uvec3(71u, 83u, 97u));
	return vec4(
		float(h1 & 0x00FFFFFFu) / 16777216.0,
		float(h2 & 0x00FFFFFFu) / 16777216.0,
		float(h3 & 0x00FFFFFFu) / 16777216.0,
		float(h4 & 0x00FFFFFFu) / 16777216.0
	);
}

// Continuous trilinear value noise for atmospheric cosmic dust (no voxel stepping)
float smooth_noise3d(vec3 p) {
	vec3 i = floor(p);
	vec3 f = fract(p);
	f = f * f * (3.0 - 2.0 * f);
	
	ivec3 ip = ivec3(i);
	float n000 = float(hash_uvec3(uvec3(ip + ivec3(1000)))) / 4294967295.0;
	float n100 = float(hash_uvec3(uvec3(ip + ivec3(1001, 1000, 1000)))) / 4294967295.0;
	float n010 = float(hash_uvec3(uvec3(ip + ivec3(1000, 1001, 1000)))) / 4294967295.0;
	float n110 = float(hash_uvec3(uvec3(ip + ivec3(1001, 1001, 1000)))) / 4294967295.0;
	float n001 = float(hash_uvec3(uvec3(ip + ivec3(1000, 1000, 1001)))) / 4294967295.0;
	float n101 = float(hash_uvec3(uvec3(ip + ivec3(1001, 1000, 1001)))) / 4294967295.0;
	float n011 = float(hash_uvec3(uvec3(ip + ivec3(1000, 1001, 1001)))) / 4294967295.0;
	float n111 = float(hash_uvec3(uvec3(ip + ivec3(1001, 1001, 1001)))) / 4294967295.0;
	
	float nx00 = mix(n000, n100, f.x);
	float nx10 = mix(n010, n110, f.x);
	float nx01 = mix(n001, n101, f.x);
	float nx11 = mix(n011, n111, f.x);
	
	float nxy0 = mix(nx00, nx10, f.y);
	float nxy1 = mix(nx01, nx11, f.y);
	
	return mix(nxy0, nxy1, f.z);
}

vec3 get_stars(vec3 dir, float time, bool is_cubemap) {
	if (dir.y < -0.05) {
		return vec3(0.0);
	}
	
	vec3 star_color_accum = vec3(0.0);
	vec3 p = dir * star_density;
	ivec3 id = ivec3(floor(p));
	
	// Moon direction for natural celestial glare attenuation
	vec3 moon_dir = normalize(vec3(-45.0, 38.0, -100.0));
	float moon_dist = length(dir - moon_dir);
	float moon_glare_fade = mix(0.25, 1.0, smoothstep(0.06, 0.20, moon_dist));
	
	for (int z = -1; z <= 1; z++) {
		for (int y = -1; y <= 1; y++) {
			for (int x = -1; x <= 1; x++) {
				ivec3 cell_id = id + ivec3(x, y, z);
				vec4 rnd = hash_cell(cell_id);
				
				// Controlled, non-noisy star density: ~11% of cells have a star
				if (rnd.x > 0.89) {
					// Fixed celestial coordinates on unit sphere
					vec3 cell_pos = vec3(cell_id) + mix(vec3(0.12), vec3(0.88), rnd.yzw);
					vec3 star_dir = normalize(cell_pos);
					
					// Exact angular chord distance
					float dist = length(dir - star_dir);
					
					// Crisp pinprick star radius (0.0016 - 0.0030 radians)
					float star_radius = mix(0.0016, 0.0030, rnd.y * rnd.y);
					
					if (dist < star_radius) {
						float d_norm = dist / star_radius;
						// Continuous anti-aliased Gaussian profile (prevents sub-pixel flickering)
						float profile = exp(-d_norm * d_norm * 4.2);
						
						// Steep power-law magnitude: mostly dim, delicate pinpricks, rare bright landmarks
						float magnitude = mix(0.25, 1.4, pow(rnd.w, 5.0)) * moon_glare_fade;
						
						// Fixed color temperature per star (pale blue-white to warm silver)
						vec3 star_tint = mix(vec3(0.82, 0.88, 1.0), vec3(1.0, 0.96, 0.90), rnd.z);
						
						// Restrained twinkle applied only to rare prominent stars in screen pass
						if (!is_cubemap && rnd.w > 0.85) {
							float twinkle = sin(time * twinkle_speed * (0.7 + rnd.y * 0.8) + rnd.x * 62.8318);
							magnitude *= (1.0 - twinkle_intensity * 0.5) + twinkle_intensity * 0.5 * twinkle;
						}
						
						star_color_accum += star_tint * profile * magnitude;
					}
				}
			}
		}
	}
	
	float horizon_fade = smoothstep(-0.01, 0.12, dir.y);
	return star_color_accum * horizon_fade * star_brightness;
}

void sky() {
	vec3 dir = normalize(EYEDIR);
	float y = dir.y;
	
	// Smooth 3-tier celestial gradient
	vec3 base_color;
	if (y >= 0.0) {
		float h = pow(clamp(y / gradient_height, 0.0, 1.0), gradient_intensity);
		vec3 grad_lower = mix(horizon_color, mid_sky_color, smoothstep(0.0, 0.35, h));
		base_color = mix(grad_lower, upper_sky_color, smoothstep(0.25, 1.0, h));
	} else {
		base_color = mix(horizon_color, ground_color, clamp(-y * 5.0, 0.0, 1.0));
	}
	
	// Continuous ethereal cosmic dust / haze
	if (haze_intensity > 0.0 && y > -0.05) {
		float n1 = smooth_noise3d(dir * 2.5 + vec3(1.2, 3.4, 5.6));
		float n2 = smooth_noise3d(dir * 5.0 + vec3(7.8, 9.1, 2.3));
		float haze = smoothstep(0.40, 0.85, (n1 + n2 * 0.5) / 1.5);
		vec3 haze_tint = vec3(0.016, 0.020, 0.040);
		base_color += haze_tint * haze * haze_intensity * smoothstep(-0.01, 0.25, y);
	}
	
	// Stable celestial starfield
	vec3 stars = get_stars(dir, TIME, AT_CUBEMAP_PASS);
	
	COLOR = base_color + stars;
}
