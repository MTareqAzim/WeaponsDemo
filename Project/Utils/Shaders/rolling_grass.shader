shader_type spatial;

uniform float camera_offset;
uniform bool billboard;
uniform float billboard_degrees;

uniform bool exclude = false;
uniform vec2 offset;

uniform sampler2D exclusion : hint_albedo;

void vertex() {
	if(exclude) {
		vec2 position = (WORLD_MATRIX * vec4(VERTEX, 1.0)).xz;
		vec2 offset_position = position + offset;
		ivec2 exclusion_isize = textureSize(exclusion, 0);
		vec2 exclusion_size = vec2(float(exclusion_isize.x), float(exclusion_isize.y)) / 100.0;
		float alpha = texture(exclusion, offset_position / exclusion_size).r;
		if (alpha < 0.9) {
			VERTEX = (inverse(WORLD_MATRIX) * CAMERA_MATRIX * vec4(0.0, 1.0, 0.0, 1.0)).xyz;
			return;
		}
	}
	
	vec4 world = WORLD_MATRIX * vec4(VERTEX, 1.0);
	vec4 camera_pos = CAMERA_MATRIX * vec4(vec3(0.0), 1.0);
	vec4 diff = (world - camera_pos);
	
	if(billboard) {
		float angle = radians(billboard_degrees);
		mat3 rotate_x = mat3(vec3(1.0, 0.0, 0.0), vec3(0.0, cos(angle), -sin(angle)), vec3(0.0, sin(angle), cos(angle)));
		VERTEX = rotate_x * VERTEX;
		NORMAL = normalize(rotate_x * NORMAL);
	}
	
	if(diff.z < -camera_offset) {
		float y_shift = -0.1 * pow(diff.z + camera_offset, 2.0);
		VERTEX = VERTEX + vec3(0.0, y_shift, 0.0);
	}
}

void fragment() {
	ALBEDO = vec3(0.8, 0.8, 0.1) * UV2.y;
}