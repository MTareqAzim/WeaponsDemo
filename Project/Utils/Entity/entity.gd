extends KinematicBody
class_name Entity

export (float) var max_speed = 10.0 setget set_max_speed, get_max_speed
export (float) var gravity = 9.8 setget set_gravity, get_gravity
export (float) var friction = 4.0 setget set_friction, get_friction
export (float) var acceleration = 4.0 setget set_acceleration, get_acceleration

var _velocity := Vector3.ZERO setget set_velocity, get_velocity
var _target_velocity_2d := Vector2.ZERO setget set_target_velocity_2d, get_target_velocity_2d

onready var groundcast = $Groundcast


func _physics_process(delta: float):
	_velocity = _apply_gravity(_velocity, delta)
	_velocity = _apply_acceleration(_velocity, _target_velocity_2d, delta)
	_velocity = _clamp_velocity(_velocity)
	
	_velocity = move_and_slide(_velocity, Vector3.UP)
	
	_velocity = _zero_out_velocity(_velocity, 0.01)


func _apply_gravity(velocity: Vector3, delta: float) -> Vector3:
	velocity.y -= gravity * delta
	
	return velocity


func _apply_acceleration(velocity: Vector3, target_velocity_2d: Vector2, delta: float) -> Vector3:
	var velocity_2d := Vector2(velocity.x, velocity.z)
	
	var final_acceleration := 0.0
	
	if target_velocity_2d == Vector2.ZERO:
		final_acceleration = friction
	else:
		if velocity_2d == Vector2.ZERO:
			final_acceleration = acceleration
		elif sign(target_velocity_2d.x) != sign(velocity_2d.x) or sign(target_velocity_2d.y) != sign(velocity_2d.y):
			final_acceleration = friction + acceleration
		else:
			final_acceleration = acceleration
	
	var final_velocity_2d = velocity_2d.move_toward(target_velocity_2d, final_acceleration * delta)
	
	var final_y_velocity = velocity.y
	
	var final_velocity = Vector3(final_velocity_2d.x, final_y_velocity, final_velocity_2d.y)
	
	return final_velocity


func _clamp_velocity(velocity: Vector3) -> Vector3:
	velocity.x = clamp(velocity.x, -max_speed, max_speed)
	velocity.y = clamp(velocity.y, -max_speed, max_speed)
	velocity.z = clamp(velocity.z, -max_speed, max_speed)
	
	return velocity


func _zero_out_velocity(velocity: Vector3, error: float) -> Vector3:
	var zeroed_velocity = velocity
	
	zeroed_velocity.x = zeroed_velocity.x if zeroed_velocity.x > error or zeroed_velocity.x < -error else 0
	zeroed_velocity.y = zeroed_velocity.y if zeroed_velocity.y > error or zeroed_velocity.y < -error else 0
	zeroed_velocity.z = zeroed_velocity.z if zeroed_velocity.z > error or zeroed_velocity.z < -error else 0
	
	return zeroed_velocity


func set_max_speed(new_max_speed: float):
	max_speed = new_max_speed


func get_max_speed() -> float:
	return max_speed


func set_gravity(new_gravity: float):
	gravity = new_gravity


func get_gravity() -> float:
	return gravity


func is_grounded() -> bool:
	if groundcast.is_colliding():
		var displacement = _get_distance_to_ground()
		if displacement < 0.065:
			return true
	
	return false


func is_near_ground(distance: float) -> bool:
	if groundcast.is_colliding():
		var displacement = _get_distance_to_ground()
		if displacement <= distance:
			return true
	
	return false


func _get_distance_to_ground() -> float:
	return (groundcast.global_transform.origin - groundcast.get_collision_point()).length()


func set_friction(new_friction: float):
	friction = new_friction


func get_friction() -> float:
	return friction


func set_acceleration(new_acceleration: float):
	acceleration = new_acceleration


func get_acceleration() -> float:
	return acceleration


func set_velocity(velocity: Vector3):
	_velocity = velocity


func set_y_velocity(y_velocity: float):
	_velocity.y = y_velocity


func get_velocity() -> Vector3:
	return _velocity


func get_y_velocity() -> float:
	return _velocity.y


func get_velocity_2d() -> Vector2:
	return Vector2(_velocity.x, _velocity.z)


func set_velocity_2d(velocity_2d: Vector2):
	var new_velocity = Vector3(velocity_2d.x, _velocity.y, velocity_2d.y)
	_velocity = new_velocity


func set_target_velocity_2d(target_velocity_2d: Vector2):
	_target_velocity_2d = target_velocity_2d


func get_target_velocity_2d() -> Vector2:
	return _target_velocity_2d
