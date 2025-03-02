extends Node

var ResourcesScript = load("res://Scripts/resources.gd")
var resource_instance : Node
@export var leather_per_cow = 1
@export var cows_needed_for_leather = 1
var production_timer: float = 0.0
var production_interval: float = 2.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func produce_leather(delta: float):
	production_timer -= delta
	
	#if production_timer <= 0:
		#if cows >= cows_needed_for_leather:
			#var leather_produced = min(cows /cows_needed_for_leather, cows) * leather_per_cow
			#leather += leather_produced
			#cows -= leather_produced
			#print("Produced ", leather_produced, " leather from cows.")
		#production_timer = production_interval
		
		
