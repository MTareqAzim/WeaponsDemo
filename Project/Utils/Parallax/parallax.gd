extends Sprite3D


export(float, 0.0, 1.0) var x_multiplier = 1.0
export(float, 0.0, 1.0) var y_multiplier = 1.0

var camera_previous_origin : Vector3


func _ready():
	var camera : Camera = get_viewport().get_camera()
	var camera_transform = camera.get_camera_transform()
	camera_previous_origin = camera_transform.origin


func _process(_delta):
	var camera : Camera = get_viewport().get_camera()
	var camera_transform = camera.get_camera_transform()
	var camera_current_origin = camera_transform.origin
	
	var x_displacement = camera_current_origin.x - camera_previous_origin.x
	var y_displacement = camera_current_origin.y - camera_previous_origin.y
	
	translate(Vector3(x_displacement * (1.0 - x_multiplier), y_displacement * (1.0 - y_multiplier), 0))
	
	camera_previous_origin = camera_current_origin
