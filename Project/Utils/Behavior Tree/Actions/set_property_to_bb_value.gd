extends BTAction

export (String) var property_name := "property_name"
export (String) var blackboard_key := "bb_key"


func update() -> int:
	if blackboard.has(blackboard_key):
		var value = blackboard.get(blackboard_key)
		actor.set(property_name, value)
		if actor.get(property_name) == value:
			return Status.SUCCESS
	
	return Status.FAILURE
