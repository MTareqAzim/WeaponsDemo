extends StateComponent
class_name TimerActivateComponentStateComponent

export (bool) var _activate := true

export (float) var time := 0.0

var _state_components : Dictionary = {}


func _ready() -> void:
	_append_state_components(self)


func enter() -> void:
	_activate_state_components(not _activate)
	_start_timer()


func _append_state_components(node : Node) -> void:
	for child in node.get_children():
		if child is StateComponent:
			_state_components[child] = child.active
		if child.get_child_count() > 0:
			_append_state_components(child)


func _start_timer() -> void:
	yield(get_tree().create_timer(time), "timeout")
	_activate_state_components(_activate)


func _activate_state_components(activate : bool) -> void:
	for child in _state_components:
		if activate:
			child.set_active(_state_components[child])
		else:
			child.set_active(activate)
