extends EntityStateComponent
class_name FulfillsStaminaCostStateComponent

export (bool) var _activate := true

export (String) var stamina_key := "stamina"
export (String) var cost_key := "cost_key"

var _state_components : Dictionary = {}
var stamina : Stamina
var cost : float


func _ready() -> void:
	_append_state_components(self)


func enter() -> void:
	_check_and_activate()


func resume() -> void:
	_check_and_activate()


func update(delta: float) -> void:
	_check_and_activate()


func assign_dependencies() -> void:
	stamina = component_state.get_dependency(stamina_key)


func assign_variables() -> void:
	cost = component_state.get_variable(cost_key)


func _append_state_components(node : Node) -> void:
	for child in node.get_children():
		if child is StateComponent:
			_state_components[child] = child.active
		if child.get_child_count() > 0:
			_append_state_components(child)


func _check_and_activate() -> void:
	if fulfills_stamina_cost():
		_activate_state_components(_activate)
	else:
		_activate_state_components(not _activate)


func fulfills_stamina_cost() -> bool:
	return cost <= stamina.get_stamina()


func _activate_state_components(activate : bool) -> void:
	for child in _state_components:
		if activate:
			child.set_active(_state_components[child])
		else:
			child.set_active(activate)
