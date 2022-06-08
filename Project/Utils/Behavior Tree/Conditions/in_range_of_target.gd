extends BTCondition

export (String) var position_key := "position"
export (String) var target_key := "target"
export (float) var max_distance := 0.0


func update() -> int:
	var position = blackboard.get(position_key)
	var target = blackboard.get(target_key)
	
	if position and target:
		if _distance_between(position, target) <= max_distance:
			return Status.SUCCESS
	
	return Status.FAILURE


func _distance_between(point_a, point_b) -> float:
	var x_difference_squared = pow((point_b.x - point_a.x), 2)
	var squished_y_difference_squared = pow((point_b.y - point_a.y)*2, 2)
	
	var distance_squared = x_difference_squared + squished_y_difference_squared
	var distance = sqrt(distance_squared)
	
	return distance
