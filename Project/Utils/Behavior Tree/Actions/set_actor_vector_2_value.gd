extends BTAction

export (String) var property_name := "property_name"
export (float) var x_value := 0.0
export (float) var y_value := 0.0


func update() -> int:
	var value = Vector2(x_value, y_value)
	actor.set(property_name, value)
	
	if actor.get(property_name) == value:
		return Status.SUCCESS
	
	return Status.FAILURE
