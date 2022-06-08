extends Node
class_name LookDirection, "look_direction.png"

signal direction_changed(new_direction)
signal x_direction_changed(new_x_direction)

var _look_direction := Vector2(1, 0) setget set_look_direction, get_look_direction
var _x_look_direction := 1 setget set_x_look_direction, get_x_look_direction


func set_look_direction_to_x_look_direction() -> void:
	set_look_direction(Vector2(_x_look_direction, 0))


func set_look_direction(new_look_direction: Vector2) -> void:
	if new_look_direction == Vector2.ZERO:
		return
	
	_look_direction = new_look_direction
	
	var new_x_look_direction = sign(_look_direction.x) \
			if abs(_look_direction.x) >= 0.3 else 0
	set_x_look_direction(new_x_look_direction)
	emit_signal("direction_changed", new_look_direction)


func get_look_direction() -> Vector2:
	return _look_direction


func set_x_look_direction(new_x_look_direction: int) -> void:
	if new_x_look_direction == 0 or new_x_look_direction == _x_look_direction:
		return
	
	_x_look_direction = new_x_look_direction
	emit_signal("x_direction_changed", new_x_look_direction)


func get_x_look_direction() -> int:
	return _x_look_direction
