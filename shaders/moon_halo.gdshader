shader_type spatial;
render_mode unshaded, blend_add, depth_draw_never, cull_disabled, shadows_disabled;

/*
 * Ethereal Moon Atmospheric Halo Shader
 * Creates a soft, additive, radially decaying atmospheric haze around the moon,
 * blending smoothly into the dark night sky.
 */

uniform vec3 halo_color : source_color = vec3(0.50, 0.62, 0.82);
uniform float halo_intensity : hint_range(0.0, 3.0, 0.05) = 0.45;
uniform float halo_falloff : hint_range(1.0, 15.0, 0.2) = 5.5;

void vertex() {
	// Billboard mode: always face camera directly
	MODELVIEW_MATRIX = VIEW_MATRIX * mat4(
		vec4(length(MODEL_MATRIX[0].xyz), 0.0, 0.0, 0.0),
		vec4(0.0, length(MODEL_MATRIX[1].xyz), 0.0, 0.0),
		vec4(0.0, 0.0, length(MODEL_MATRIX[2].xyz), 0.0),
		vec4(MODEL_MATRIX[3].xyz, 1.0)
	);
}

void fragment() {
	float dist = length(UV - vec2(0.5)) * 2.0; // 0 at center, 1 at edge
	if (dist > 1.0) {
		discard;
	}
	float glow = exp(-dist * halo_falloff) * smoothstep(1.0, 0.6, dist);
	ALBEDO = halo_color * halo_intensity;
	ALPHA = glow;
}
