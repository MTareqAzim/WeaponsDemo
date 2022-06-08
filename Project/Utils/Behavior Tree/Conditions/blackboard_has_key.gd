extends BTCondition


export (String) var key_to_check := "key"


func update() -> int:
	if blackboard.has(key_to_check):
		return Status.SUCCESS
	
	return Status.FAILURE
