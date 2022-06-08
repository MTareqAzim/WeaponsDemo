extends BTAction


export (String) var function_name := "function"
export (String) var arg := "value"


func update() -> int:
	if actor.has_method(function_name):
		actor.call(function_name, arg)
		return Status.SUCCESS
	
	return Status.FAILURE
