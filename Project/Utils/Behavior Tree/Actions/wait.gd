extends BTAction


export (String) var delta_key := "delta"
export (float) var seconds_to_wait := 0.0

var total_time : float = 0.0
var first_pass : bool = false


func on_initialize() -> void:
	total_time = 0.0
	first_pass = true


func update() -> int:
	if not blackboard.has(delta_key):
		return Status.FAILURE
	
	if first_pass:
		if total_time >= seconds_to_wait:
			return Status.FAILURE
		first_pass = false
		return Status.RUNNING
	
	total_time += blackboard.get(delta_key)
	
	if total_time >= seconds_to_wait:
		return Status.SUCCESS
	
	return Status.RUNNING
