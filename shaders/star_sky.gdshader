shader_type sky;

uniform float star_density : hint_range(0.0, 0.1) = 0.001;
uniform vec3 star_color : source_color = vec3(1.0);
uniform float twinkle_speed : hint_range(0.0, 10.0) = 2.0;

void sky() {
	// Base dark background
	COLOR = vec3(0.0, 0.0, 0.05);

	// Random star field using EYEDIR-derived UV
	vec2 uv = EYEDIR.xz / (abs(EYEDIR.y) + 0.001);
	float rnd = fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);

	if (rnd < star_density) {
		float twinkle = sin(TIME * twinkle_speed + rnd * 6.2831) * 0.5 + 0.5;
		COLOR = mix(COLOR, star_color, twinkle);
	}
}
