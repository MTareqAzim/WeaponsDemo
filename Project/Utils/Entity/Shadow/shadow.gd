extends RayCast


onready var shadow = $Shadow


func _process(_delta):
	var collision_point = get_collision_point()
	var shadow_pos_y = collision_point.y
	shadow_pos_y += 0.0001
	shadow.global_transform.origin.y = shadow_pos_y
