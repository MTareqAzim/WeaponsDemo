extends EntityStateComponent
class_name ReplenishStaminaStateComponent


export (String) var stamina_key := "stamina"
export (String) var regen_rate_key := "regen_rate"

var stamina : Stamina
var regen_rate : float


func update(delta: float) -> void:
	var replenish_amount = regen_rate * delta
	stamina.replenish_stamina(replenish_amount)


func assign_dependencies() -> void:
	stamina = component_state.get_dependency(stamina_key)


func assign_variables() -> void:
	regen_rate = component_state.get_variable(regen_rate_key)
