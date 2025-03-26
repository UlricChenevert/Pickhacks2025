extends CharacterBody2D

class_name Worker

enum MovementState {idle = 0, walk = 1}

var workerSpeed = 20
var targetPosition : Vector2
var moveRange = 10

@onready var homePosition = self.global_position
@export var movementState : MovementState = MovementState.idle
