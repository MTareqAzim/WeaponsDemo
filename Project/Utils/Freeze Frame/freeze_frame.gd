extends Node
class_name FreezeFrame


func freeze_frame(time_scale: float, duration: float) -> void:
	Engine.time_scale = time_scale
	yield(get_tree().create_timer(duration * time_scale), "timeout")
	Engine.time_scale = 1.0
