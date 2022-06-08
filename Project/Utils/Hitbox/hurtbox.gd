extends Area

signal hit(damage)

export(NodePath) var body_path

onready var body = get_node(body_path)


func on_hit(damage: int) -> void:
	emit_signal("hit", damage)
