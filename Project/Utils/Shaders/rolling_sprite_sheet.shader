shader_type spatial;

uniform float camera_offset;
uniform bool billboard;
uniform float billboard_degrees;
uniform sampler2D texturemap : hint_albedo;
uniform int h_frames = 1;
uniform int v_frames = 1;
uniform int frame = 0;

void vertex() {
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
	float h_increment = 1.0 / float(h_frames);
	float v_increment = 1.0 / float(v_frames);
	vec2 frame_pos = vec2(float(frame % h_frames), float(frame / v_frames));
	vec2 uv_scale = vec2(h_increment, v_increment);
	vec2 new_uv = UV * uv_scale + frame_pos * uv_scale;
	ALBEDO = texture(texturemap, new_uv).rgb;
	ALPHA = texture(texturemap, new_uv).a;
}