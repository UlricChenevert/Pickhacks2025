extends Node2D

enum ProductionType {herder = 0, tailor = 1}

@onready var population = $Workers # Worker[]
@onready var resources = $Resources # Either leather or cows
@export var workerAmt = 5
var type : ProductionType = ProductionType.herder

func _ready(): 
	for i in range(workerAmt):
		# Load the scene you want to instance
		var scene = preload("res://Scene/Worker.tscn")
		
		# Create an instance of the scene
		var instance = scene.instantiate()
		
		# Add it as a child of the current node
		population.add_child(instance)

func consumeStage(delta : float):
	var workers = population.get_children()
	
	for worker in workers:
		worker.decayClothes(delta)
		worker.decayFood(delta)

func productionStage(delta : float):
	var workers = population.get_children()
	
	for worker in workers:
		continue
	
func tradeStage(delta : float):
	var workers = population.get_children()
	
	for worker in workers:
		continue
	
