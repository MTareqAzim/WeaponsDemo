extends BTAction


export (String) var key_to_delete := "key"


func update() -> int:
	blackboard.erase(key_to_delete)
	
	if not blackboard.has(key_to_delete):
		return Status.SUCCESS
	
	return Status.FAILURE
