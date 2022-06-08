extends StateComponent
class_name DelayedActivationStateComponent

export (float) var delay := 0.0
export (bool) var _activate : bool = true

onready var timer : Timer = $Timer

var _state_components : Dictionary = {}
var _activated : bool


func _ready() -> void:
	_append_state_components(self)
	_set_activated(not _activate, true)
	timer.wait_time = delay
	timer.one_shot = true


func enter() -> void:
	_set_activated(not _activate)
	timer.start()


func resume() -> void:
	_set_activated(not _activate)
	timer.start()


func exit() -> void:
	timer.stop()


func _on_Timer_timeout() -> void:
	_set_activated(_activate)


func _append_state_components(node : Node) -> void:
	for i in node.get_child_count():
		var child = node.get_child(i)
		if child is StateComponent:
			_state_components[child] = child.active
		if child.get_child_count() > 0:
			_append_state_components(child)


func _set_activated(activated: bool, force: bool = false) -> void:
	if not force:
		if _activated == activated:
			return
	
	_activated = activated
	_activate_children(_activated)


func _activate_children(active: bool) -> void:
	for component in _state_components:
		if active:
			component.set_active(_state_components[component])
		else:
			component.set_active(active)
