extends Area

signal hit

export(NodePath) var body_path
export(int) var damage := 0 setget set_damage


onready var body = get_node(body_path)


func _on_area_entered(area):
	if area.body != body:
		if area.has_method("on_hit"):
			area.on_hit(damage)
			emit_signal("hit")


func set_damage(new_damage: int) -> void:
	damage = new_damage
