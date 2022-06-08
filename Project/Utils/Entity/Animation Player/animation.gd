extends AnimationPlayer

export(String) var initial_animation


func _ready():
	play(initial_animation)


func _on_StateMachine_state_changed(current_state):
	play(current_state)
