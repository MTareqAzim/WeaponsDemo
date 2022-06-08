extends StateComponent
class_name PressedTransitionStateComponent, "pressed_transition_state_component.png"

export (String) var ACTION
export (String) var NEXT_STATE


func get_class() -> String:
	return "PressedTransitionStateComponent"


func handle_input(event: InputAction) -> void:
	if event.is_action_pressed(ACTION):
		component_state.finished(NEXT_STATE)
