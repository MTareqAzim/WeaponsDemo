extends BTAction


export (String) var actor_function := "function"


func update() -> int:
	if actor.has_method(actor_function):
		actor.call(actor_function)
		return Status.SUCCESS
	
	return Status.FAILURE
