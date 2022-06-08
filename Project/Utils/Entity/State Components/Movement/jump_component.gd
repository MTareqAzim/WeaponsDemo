extends EntityStateComponent

export (String) var max_jump_height_key := "max_jump_height"
export (String) var jump_duration_key := "jump_duration"

var _max_jump_height : float
var _jump_duration : float


func enter():
	_set_values()


func assign_variables() -> void:
	_max_jump_height = component_state.get_variable(max_jump_height_key)
	_jump_duration = component_state.get_variable(jump_duration_key)


func _set_values():
	var new_gravity = (2 * _max_jump_height) / pow(_jump_duration, 2)
	var y_velocity = new_gravity * _jump_duration
	
	$"EnterGravity".args = [new_gravity]
	$"EnterYVelocity".args = [y_velocity]
