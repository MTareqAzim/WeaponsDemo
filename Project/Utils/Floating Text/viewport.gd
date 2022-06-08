extends Viewport

onready var label = $Label


func _process(delta):
	size = label.rect_size
