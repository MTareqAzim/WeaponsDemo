extends KinematicBody


export(NodePath) var target_path
export(bool) var lock_y
export(float) var jitter_margin := 0.01
export(float) var x_distance := 2.0
export(float) var z_distance := 1.0

onready var target = get_node(target_path)


func _physics_process(delta):
	move_to_target(delta)


func move_to_target(delta):
	var target_transform : Transform = target.global_transform
	var displacement = target_transform.origin - global_transform.origin
	
	if lock_y:
		displacement.y = 0
	
	displacement = _alleviate_jitter(displacement)
	
	if abs(displacement.x) > x_distance:
		displacement.x -= x_distance * sign(displacement.x)
	else:
		displacement.x = 0.0
	
	if abs(displacement.z) > z_distance:
		displacement.z -= z_distance * sign(displacement.z)
	else:
		displacement.z = 0.0
	
	move_and_slide(displacement / delta, Vector3.UP)


func _alleviate_jitter(displacement: Vector3) -> Vector3:
	if displacement.x < jitter_margin and displacement.x > -jitter_margin:
		displacement.x = 0
	if displacement.y < jitter_margin and displacement.y > -jitter_margin:
		displacement.y = 0
	if displacement.z < jitter_margin and displacement.z > -jitter_margin:
		displacement.z = 0
	
	return displacement


func translate_to_target():
	var target_transform : Transform = target.global_transform
	global_translate(target_transform.origin - global_transform.origin)
