extends Sprite3D


onready var tween = $Tween
onready var viewport = $Viewport

var velocity = Vector3(0.0, 3.0, 0.0)
var gravity = Vector3(0.0, -8.0, 0.0)


func _ready():
	var viewport_texture = viewport.get_texture()
	texture = viewport_texture
	
	tween.interpolate_property(self, "scale", scale, Vector3(1, 1, 1), 0.3, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.interpolate_callback(self, 0.8, "queue_free")
	tween.start()


func _process(delta):
	velocity += gravity * delta
	translate(velocity * delta)


func set_text(new_text) -> void:
	$Viewport/Label.text = str(new_text)


func get_text() -> String:
	return $Viewport/Label.text


func set_color(color: Color) -> void:
	$Viewport/Label.set("custom_colors/font_color", color)
