shader_type spatial;

uniform float camera_roll_offset = 9.0;
uniform vec4 color : hint_color;

void vertex() {
	vec4 world = WORLD_MATRIX * vec4(VERTEX, 1.0);
	vec4 origin_world = WORLD_MATRIX * vec4(vec3(0.0), 1.0);
	vec4 camera_pos = CAMERA_MATRIX * vec4(vec3(0.0), 1.0);
	vec4 vertex_diff = world - camera_pos;
	vec4 world_diff = origin_world - camera_pos;
	if(vertex_diff.z < -camera_roll_offset) {
		float vertex_y_shift = -0.1 * pow(vertex_diff.z + camera_roll_offset, 2.0);
		float world_y_shift = -0.1 * pow(world_diff.z + camera_roll_offset, 2.0);
		float y_shift = vertex_y_shift - world_y_shift;
		VERTEX = VERTEX + vec3(0.0, y_shift, 0.0);
	}
}

void fragment() {
	ALBEDO = color.rgb;
}