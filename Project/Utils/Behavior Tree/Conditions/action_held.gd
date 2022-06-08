extends BTCondition


export (String) var function_name := "function"
export (String) var action := "action"


func update() -> int:
	if actor.has_method(function_name):
		if actor.call(function_name, action):
			return Status.SUCCESS
	
	return Status.FAILURE
