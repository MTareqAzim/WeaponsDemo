shader_type spatial;

uniform sampler2D texturemap : hint_albedo;
uniform vec2 texture_scale = vec2(20.0, 20.0);

void vertex() {
	vec4 world = WORLD_MATRIX * vec4(VERTEX, 1.0);
	vec4 camera_pos = CAMERA_MATRIX * vec4(vec3(0.0), 1.0);
	vec4 diff = (world - camera_pos) / 1.0;
	float offset = -8.0;
	if(diff.z < offset) {
		float y_shift = -0.1 * pow(diff.z - offset, 2.0);
		VERTEX = VERTEX + vec3(0.0, y_shift, 0.0);
	}
}

void fragment() {
	ALBEDO = texture(texturemap, UV * texture_scale).rgb;
}