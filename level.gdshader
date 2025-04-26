shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform sampler2D noise : repeat_enable;
uniform vec2 scroll = vec2(0.05, 0.05);
uniform sampler2D noise2 : repeat_enable;
uniform vec2 scroll2 = vec2(0.05, 0.05);
uniform float distortion_strength : hint_range(-1, 1) = 0.006;
uniform vec4 tone_color : source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float depth = texture(noise, UV + scroll * TIME).r * 
	texture(noise2, UV + scroll2 * TIME).r;
	vec4 noise_col = texture(noise, UV + scroll * TIME);
	vec4 screen_col = texture(SCREEN_TEXTURE, 
	 SCREEN_UV + distortion_strength * noise_col.r, -1);
	COLOR = screen_col * 0.8 + 0.5 * tone_color; // screen_col * tone_color;
	
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
