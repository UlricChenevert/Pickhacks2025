extends CharacterBody2D

enum worker_state {IDLE}

@export var move_speed: float = 100 

var direction_change_timer: float = 0.0 # timer to change direction
var direction_change_interval: float = 2.0 #Interval to change direction (in seconds)
func _physics_process(delta: float) -> void:
	direction_change_timer -= delta
	
	if state == worker_state.IDLE:

	if direction_change_timer <= 0:
		velocity.x = randf_range(-1,1) * move_speed
		velocity.y = randf_range(-1,1) * move_speed 
	
	
	
