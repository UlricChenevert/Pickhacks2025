extends Node

func workerMovement(workers : Array[Worker], delta : float):
	for worker in workers:
		moveToTarget(worker, delta)

func moveToTarget(worker : Worker, delta : float):
	if (worker.movementState == worker.MovementState.idle): return
	# assumes worker.targetPosition not null after this point
	
	# Get distance to position, normalize to to -1, 1 and scale it to worker speed
	var velocity : Vector2 = (worker.targetPosition - worker.global_position).normalized() * worker.workerSpeed
	var frameDelta = velocity * delta
		
	# Move towards target
	worker.position += frameDelta
	#var collisonInfo = worker.move_and_collide(frameDelta)
		
	# Check if arrived at destination (with a small threshold)
	if (worker.global_position.distance_to(worker.targetPosition) < frameDelta.length()):
		worker.movementState = worker.MovementState.idle
		
	# Check if ran into wall
	#if (collisonInfo):
		#worker.movementState = worker.MovementState.idle

func setRandomTarget(worker : Worker):
	if (worker.movementState != worker.MovementState.idle || randi_range(0, 4) != 0): return
	
	worker.movementState = worker.MovementState.walk
	worker.targetPosition = Vector2(
		randi_range(-worker.moveRange + worker.global_position.x, worker.moveRange + worker.global_position.x), 
		randi_range(-worker.moveRange + worker.global_position.y, worker.moveRange + worker.global_position.y))

func setTarget(worker : Worker, targetPosition : Vector2):
	#if (worker.movementState == worker.MovementState.walk): return
	
	worker.movementState = worker.MovementState.walk
	worker.targetPosition = targetPosition
