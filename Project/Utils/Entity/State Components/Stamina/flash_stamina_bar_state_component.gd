extends EntityStateComponent
class_name FlashStaminaBarStateComponent

export (String) var stamina_key := "stamina"
export (String) var hud_key := "hud"
export (String) var action
export (String) var action_cost_key := "action_cost"
export (Color) var color

var stamina : Stamina
var hud
var cost : float

func assign_dependencies() -> void:
	stamina = component_state.get_dependency(stamina_key)
	hud = component_state.get_dependency(hud_key)


func assign_variables() -> void:
	cost = component_state.get_variable(action_cost_key)


func handle_input(event : InputEvent) -> void:
	if event.is_action_pressed(action):
		if not fulfills_stamina_cost():
			hud.stamina_bar_flash(color)


func fulfills_stamina_cost() -> bool:
	return cost <= stamina.get_stamina()
