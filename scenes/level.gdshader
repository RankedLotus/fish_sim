shader_type canvas_item;

uniform vec2 center;
uniform float force;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 disp = normalize(UV - center) * force; //direction from center to current coordinate
	//COLOR = vec4(UV - disp, 1.0 , 1.0);
	COLOR = texture(TEXTURE, UV - disp);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
