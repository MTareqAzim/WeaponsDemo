extends BTCondition


export (String) var actor_function := "function"
export (String) var blackboard_key := "blackboard_key"


func update() -> int:
	if blackboard.has(blackboard_key):
		if actor.has_method(actor_function):
			if actor.call(actor_function, blackboard.get(blackboard_key)):
				return Status.SUCCESS
	
	return Status.FAILURE
