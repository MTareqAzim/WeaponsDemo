extends EntityStateComponent
class_name InvertLookDirectionExitStateComponent, "look_direction_exit.png"

export (String) var look_direction_key := "look"

var _look_direction : LookDirection

func enter() -> void:
	var look_direction = _look_direction.get_look_direction()
	var x_look_direction = _look_direction.get_x_look_direction()
	
	_update_look_direction(Vector2(x_look_direction, look_direction.y) * -1)


func assign_dependencies() -> void:
	_look_direction = component_state.get_dependency(look_direction_key)


func _update_look_direction(direction: Vector2) -> void:
	if _look_direction.get_look_direction() == direction:
		return
	
	_look_direction.set_look_direction(direction)
