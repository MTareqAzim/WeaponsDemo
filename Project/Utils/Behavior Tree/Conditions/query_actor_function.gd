extends BTCondition


export (String) var actor_function := "function"


func update() -> int:
	if actor.has_method(actor_function):
		if actor.call(actor_function):
			return Status.SUCCESS
	
	return Status.FAILURE
