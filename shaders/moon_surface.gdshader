shader_type spatial;
render_mode unshaded, blend_mix, depth_draw_opaque, cull_back;

/*
 * Dark Souls-Inspired High-Resolution Lunar Surface Shader
 * Uses NASA Lunar Reconnaissance Orbiter (LROC) 2K Albedo & LOLA Normal Mapping.
 * Features:
 * - Equirectangular high-resolution lunar albedo (maria, highland anorthosite, ray craters)
 * - Tangent-space normal mapping derived from NASA LOLA laser altimeter elevation
 * - Lommel-Seeliger regolith scattering approximation for physically plausible porous lunar soil
 * - Restrained cool specular highlight on crater rims
 * - Delicate atmospheric limb darkening and silver-blue Fresnel rim
 */

group_uniforms Lunar_Textures;
uniform sampler2D albedo_texture : source_color, filter_linear_mipmap;
uniform sampler2D normal_map : hint_normal, filter_linear_mipmap;
uniform float normal_depth : hint_range(0.0, 3.0, 0.05) = 1.1;

group_uniforms Color_and_Tone;
uniform vec3 moon_tint : source_color = vec3(0.86, 0.90, 0.96);
uniform float brightness : hint_range(0.1, 3.0, 0.05) = 1.18;
uniform float contrast : hint_range(0.5, 2.0, 0.05) = 1.08;

group_uniforms Surface_Lighting;
uniform float ambient_fill : hint_range(0.1, 1.0, 0.05) = 0.78;
uniform float rough_highlight : hint_range(0.0, 1.0, 0.05) = 0.12;
uniform vec3 sun_direction = vec3(0.35, 0.25, 0.90);

group_uniforms Atmospheric_Limb;
uniform float limb_exponent : hint_range(0.5, 4.0, 0.1) = 1.4;
uniform vec3 rim_glow_color : source_color = vec3(0.60, 0.72, 0.90);
uniform float rim_glow_intensity : hint_range(0.0, 1.0, 0.02) = 0.24;

void fragment() {
	// Tangent-space normal mapping for realistic crater relief
	vec3 n_map = texture(normal_map, UV).rgb * 2.0 - 1.0;
	n_map.xy *= normal_depth;
	n_map = normalize(n_map);
	mat3 tbn = mat3(TANGENT, BINORMAL, NORMAL);
	vec3 norm = normalize(tbn * n_map);
	
	// Sample NASA LROC albedo map
	vec3 tex = texture(albedo_texture, UV).rgb;
	tex = pow(tex, vec3(contrast));
	vec3 albedo = tex * moon_tint;
	
	// Oblique solar illumination revealing crater relief
	vec3 l_dir = normalize(sun_direction);
	float NdotL = clamp(dot(norm, l_dir), 0.0, 1.0);
	float NdotV = clamp(dot(norm, VIEW), 0.001, 1.0);
	
	// Lommel-Seeliger scattering (porous lunar regolith retroreflection)
	float ls = NdotL / (NdotL + NdotV + 0.001);
	float light_term = mix(ambient_fill, 1.0, mix(NdotL, ls * 1.35, 0.40));
	
	// Restrained cool rough highlight on crater rims
	vec3 H = normalize(l_dir + VIEW);
	float spec = pow(clamp(dot(norm, H), 0.0, 1.0), 16.0) * rough_highlight;
	
	// Astronomical limb-darkening and subtle atmospheric Fresnel rim
	float limb = pow(NdotV, 1.0 / limb_exponent);
	float fresnel = pow(1.0 - NdotV, 3.5) * rim_glow_intensity;
	
	vec3 final_color = albedo * light_term * limb + spec * vec3(0.82, 0.88, 1.0) + rim_glow_color * fresnel;
	
	ALBEDO = final_color * brightness;
}
