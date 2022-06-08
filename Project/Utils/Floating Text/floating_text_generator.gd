extends Position3D

var floating_text_preload = preload("res://Utils/Floating Text/FloatingText.tscn")


func generate_text(text: String, color: Color = Color.whitesmoke) -> void:
	var floating_text = floating_text_preload.instance()
	floating_text.set_text(text)
	floating_text.set_color(color)
	
	add_child(floating_text)
