shader_type spatial;

void vertex() {
	vec4 vertex_world_pos = WORLD_MATRIX * vec4(VERTEX, 1.0);
	vec4 origin_world_pos = WORLD_MATRIX * vec4(vec3(0.0), 1.0);
	vec4 camera_pos = CAMERA_MATRIX * vec4(vec3(0.0), 1.0);
	vec4 vertex_to_camera = camera_pos - vertex_world_pos;
	vec4 origin_to_camera = camera_pos - origin_world_pos;
	
	vec2 forward_vec = vec2(0.0, 1.0);
	float y_angle = acos(dot(origin_to_camera.xz, forward_vec) / (length(origin_to_camera.xz) * length(forward_vec))) * sign(-origin_to_camera.x);
	mat3 rotate_y = mat3(vec3(cos(y_angle), 0.0, sin(y_angle)), vec3(0.0, 1.0, 0.0), vec3(-sin(y_angle), 0.0, cos(y_angle)));
	
	float x_angle = acos(dot(origin_to_camera.yz, vertex_to_camera.yz) / (length(origin_to_camera.yz) * length(vertex_to_camera.yz)));
	float y_scale = 1.0;
	mat3 scale = mat3(vec3(1.0, 0.0, 0.0), vec3(0.0, y_scale, 0.0), vec3(0.0, 0.0, 1.0));
	
	VERTEX = scale * rotate_y * VERTEX;
	NORMAL = normalize(rotate_y * NORMAL);
}