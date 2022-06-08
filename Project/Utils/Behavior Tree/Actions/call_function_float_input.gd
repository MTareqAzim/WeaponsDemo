extends BTAction


export (String) var function_name := "function"
export (float) var float_arg := 0.0


func update() -> int:
	if actor.has_method(function_name):
		actor.call(function_name, float_arg)
		return Status.SUCCESS
	
	return Status.FAILURE
