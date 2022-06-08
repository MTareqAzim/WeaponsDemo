extends BTAction

export (String) var position_key := "position"
export (String) var target_key := "target"
export (String) var heading_key := "heading"


func update() -> int:
	var position = blackboard.get(position_key)
	var target = blackboard.get(target_key)
	
	if position != null and target != null:
		var heading = (target - position).normalized()
		heading = Vector2(heading.x, heading.y * 2).normalized()
		
		blackboard.set(heading_key, heading)
		
		if blackboard.get(heading_key) == heading:
			return Status.SUCCESS
	
	return Status.FAILURE
