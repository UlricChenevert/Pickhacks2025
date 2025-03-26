extends CharacterBody2D

class_name Cow

enum cowState {idle = 0, walk = 1}

var cowSpeed = 50
var targetPosition : Vector2
var moveRange = 30

@export var state : cowState = cowState.idle
