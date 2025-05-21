shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform sampler2D noise : repeat_enable;
uniform vec2 scroll = vec2(0.002, 0.002);
uniform sampler2D noise2 : repeat_enable;
uniform vec2 scroll2 = vec2(0.003, 0.003);
uniform float distortion_strength = 1.0;
uniform vec2 my_unique_strength = vec2(10.0, 10.0);
uniform vec4 tone_color : source_color;
uniform vec4 top_color : source_color;
uniform float light_start : hint_range(0.0, 1.0) = 0.275;
uniform float light_end : hint_range(0.0, 1.0) = 0.4;

void vertex() {
	// Called for every vertex the material is visible on.
}

uniform float s2 = 2.0;

void fragment() {
	float depth = texture(noise, UV + scroll * TIME * 0.2).r * 
	texture(noise2, UV + scroll2 * TIME * 0.2).r;
	vec4 noise_col = texture(noise, UV + scroll * TIME * 0.2);
	vec2 my_strength = distortion_strength * 3.5 * noise_col.rg;
	vec4 screen_col = texture(SCREEN_TEXTURE, 
	 SCREEN_UV + s2 * distortion_strength * noise_col.r, -1);
	vec4 top_light = smoothstep(0.2, 0.25, depth) * tone_color;
	if (depth > 0.2 && depth < 0.6) {
		COLOR = screen_col * 0.8 + 0.5 * tone_color + top_light * depth * 0.2;
	} else {
		COLOR = screen_col * 0.8 + 0.5 * tone_color + top_light * 0.8 * 0.2;
	}
	 //+ smoothstep(0.2, 0.4, depth) * tone_color * 0.5; // screen_col * tone_color;
	//COLOR = screen_col * tone_color + smoothstep(0.2, 0.3, depth) * tone_color;// + top_light;
	//COLOR.a = 1.0;
	
	//COLOR = screen_col * tone_color * 4.0 + top_light * 20.0;
	//COLOR.a = 1.0;
	
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
