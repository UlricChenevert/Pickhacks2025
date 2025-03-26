extends Node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var cows = self.get_children()
	
	for cow in cows:
		cowMovement(cow, delta)

func cowMovement(cow : Cow, delta: float):	
	if (cow.state == cow.cowState.idle):
		if (randi_range(0, 16) == 1):
			cow.state = cow.cowState.walk
			cow.targetPosition = Vector2(
				randi_range(cow.moveRange + cow.position.x, -1 * cow.moveRange + cow.position.x),
				randi_range(cow.moveRange + cow.position.y, -1 * cow.moveRange + cow.position.y)
				)
			
	elif (cow.state == cow.cowState.walk):
		# Get distance to position, normalize to to -1, 1 and scale it to cow speed
		var velocity : Vector2 = (cow.targetPosition - cow.position).normalized() * cow.cowSpeed
		var frameDelta = velocity * delta
		
		# Move towards target
		var collisonInfo = cow.move_and_collide(frameDelta)
		
		# Check if ran into wall
		if (collisonInfo):
			cow.state = cow.cowState.idle
		
		# Check if arrived at destination (with a small threshold)
		if (cow.position - cow.targetPosition < frameDelta):
			cow.state = cow.cowState.idle
