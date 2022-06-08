extends EntityStateComponent
class_name ExhaustStaminaStateComponent


export (String) var stamina_key := "stamina"
export (String) var exhaust_rate_key := "exhaust_rate"

var stamina : Stamina
var exhaust_rate : float


func update(delta: float) -> void:
	var exhaust_amount = exhaust_rate * delta
	stamina.exhaust_stamina(exhaust_amount)


func assign_dependencies() -> void:
	stamina = component_state.get_dependency(stamina_key)


func assign_variables() -> void:
	exhaust_rate = component_state.get_variable(exhaust_rate_key)
