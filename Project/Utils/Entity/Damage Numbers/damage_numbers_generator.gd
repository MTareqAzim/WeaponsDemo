extends Node2D


var floating_text_scene = preload("res://Utils/Floating Text/FloatingText.tscn")


func _on_Health_damaged(amount):
	var floating_text = floating_text_scene.instance()
	
	floating_text.text = amount
	
	add_child(floating_text)
	
