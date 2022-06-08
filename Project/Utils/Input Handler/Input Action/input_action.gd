extends Resource
class_name InputAction

var action: String = "" setget set_action, get_action
var pressed: bool = false setget set_pressed, get_pressed


func is_action(name):
	return name == action


func is_pressed():
	return pressed


func is_action_pressed(name):
	return name == action and pressed


func set_action(new_action):
	action = new_action


func get_action():
	return action


func set_pressed(new_pressed):
	pressed = new_pressed


func get_pressed():
	return pressed
