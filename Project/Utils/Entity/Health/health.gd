extends Node
class_name Health, "health.png"

signal health_changed(health)
signal max_health_changed(new_max_health)
signal healed(amount)
signal damaged(amount)
signal died

export (float, 0, 2147483647) var max_health setget set_max_health, get_max_health

export (float, 0, 2147483647) var current_health : float = 0 setget _set_health, get_health


func heal_health(amount: float) -> void:
	if amount > 0:
		_set_health(current_health + amount)
		emit_signal("healed", amount)


func damage_health(amount: float) -> void:
	if amount > 0:
		_set_health(current_health - amount)
		emit_signal("damaged", amount)


func _set_health(new_health: float) -> void:
	var previous_health = current_health
	current_health = clamp(new_health, 0, max_health)
	
	if current_health != previous_health:
		emit_signal("health_changed", current_health)
		
		if current_health == 0:
			emit_signal("died")


func get_health() -> float:
	return current_health


func set_max_health(new_max_health: float) -> void:
	if new_max_health <= 0:
		return
	
	max_health = new_max_health
	_set_health(current_health)
	emit_signal("max_health_changed", max_health)


func get_max_health() -> float:
	return max_health
