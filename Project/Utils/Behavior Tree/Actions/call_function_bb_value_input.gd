extends BTAction


export (String) var function_name := "function"
export (String) var blackboard_key := "blackboard key"


func update() -> int:
	if blackboard.has(blackboard_key):
		if actor.has_method(function_name):
			actor.call(function_name, blackboard.get(blackboard_key))
			return Status.SUCCESS
	
	return Status.FAILURE
