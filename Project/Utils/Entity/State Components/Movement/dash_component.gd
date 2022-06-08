extends EntityStateComponent

export (String) var look_direction_key := "look"
export (String) var dash_distance_key = "dash_distance"
export (String) var dash_duration_key = "dash_duration"
export (bool) var x_direction_only = false

var _look_direction : LookDirection
var _dash_distance : float
var _dash_duration : float


func enter() -> void:
	_set_values()


func assign_dependencies() -> void:
	_look_direction = component_state.get_dependency(look_direction_key)


func assign_variables() -> void:
	_dash_distance = component_state.get_variable(dash_distance_key)
	_dash_duration = component_state.get_variable(dash_duration_key)


func _set_values() -> void:
	var speed : float = _dash_distance / _dash_duration
	var direction : Vector2 = Vector2(_look_direction.get_x_look_direction(), 0) if x_direction_only \
									else _look_direction.get_look_direction()
	direction = direction.normalized()
	
	$"Velocity2D".args = [direction * speed]
	$"TargetVelocity2D".args = [direction * speed]

