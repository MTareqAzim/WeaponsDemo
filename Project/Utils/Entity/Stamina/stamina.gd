extends Node
class_name Stamina, "stamina.png"

signal stamina_changed(stamina)
signal max_stamina_changed(new_max_stamina)
signal replenished
signal exhausted

export (float, 0, 2147483647) var max_stamina setget set_max_stamina, get_max_stamina

export (float, 0, 2147483647) var current_stamina : float = 0 setget _set_stamina, get_stamina


func replenish_stamina(amount: float) -> void:
	if amount > 0:
		_set_stamina(current_stamina + amount)
		emit_signal("replenished")


func exhaust_stamina(amount: float) -> void:
	if amount > 0:
		_set_stamina(current_stamina - amount)
		emit_signal("exhausted")


func _set_stamina(new_stamina: float) -> void:
	var previous_stamina = current_stamina
	current_stamina = (clamp(new_stamina, 0, max_stamina))
	
	if current_stamina != previous_stamina:
		emit_signal("stamina_changed", current_stamina)


func get_stamina() -> float:
	return current_stamina


func set_max_stamina(new_max_stamina: float) -> void:
	if new_max_stamina <= 0:
		return
	
	max_stamina = new_max_stamina
	_set_stamina(current_stamina)
	emit_signal("max_stamina_changed", max_stamina)


func get_max_stamina() -> float:
	return max_stamina
