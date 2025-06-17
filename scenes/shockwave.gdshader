shader_type canvas_item;

uniform vec2 center;
uniform float force;
uniform float size;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float ratio = SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y; // get aspect ratio
	
	vec2 scaledUV = (SCREEN_UV - vec2(0.5, 0) ) / vec2(ratio, 1.0) + vec2(0.5, 0); //bring the uv to the left, scale the x-axis & bring back right
	float mask = (1.0 - smoothstep(size - 0.1, size, length(scaledUV - center)))
	* smoothstep(size - 0.2, size - 0.1, length(scaledUV - center)); // 1.0 - to invert
	vec2 disp = normalize(SCREEN_UV - center) * force * mask; //direction from center to current coordinate
	//COLOR = vec4(UV - disp, 1.0 , 1.0);
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV - disp) * 1.2 * mask;
	//COLOR.rgb = vec3(mask);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
