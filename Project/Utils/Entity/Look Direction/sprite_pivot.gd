extends Spatial

export(Array, NodePath) var sprites_path

var sprites : Array


func _ready():
	sprites = []
	
	for sprite_path in sprites_path:
		sprites.append(get_node(sprite_path))


func _on_Look_x_direction_changed(new_x_direction):
	for sprite in sprites:
		sprite.flip_h = new_x_direction == -1
