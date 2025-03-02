extends Node2D

enum ProductionType {barren = 0, herder = 1, tailor = 2}
var stageIteration = 0
var stageAmt = 2

@onready var population = $Workers # Worker[]
@onready var resources = $Resources # Either leather or cows
@onready var timer = $Timer

@export var workerAmt = 5
@export var type : ProductionType = ProductionType.barren


var LeatherToClothConversion = 0.2
var CowToFoodConversion = 10
var CowToLeatherConversion = 1

func _ready(): 
	for i in range(workerAmt):
		# Load the scene you want to instance
		var scene = preload("res://Scene/Worker.tscn")
		
		# Create an instance of the scene
		var instance = scene.instantiate()
		
		# Add it as a child of the current node
		population.add_child(instance)
		
		debugSetAllWorkerAmts()

func _process(delta: float) -> void:
	consumeStage(delta)
	

func _on_timer_timeout() -> void:
	stageIteration += 1
	
	if (stageIteration % stageAmt == 0):
		productionStage()
	elif (stageIteration % stageAmt == 1):
		tradeStage()

func consumeStage(delta : float):
	var workers = population.get_children()
	
	for worker in workers:
		worker.decayClothes(delta)
		worker.decayFood(delta)

func productionStage():
	print("producing.....")
	var workers = population.get_children()
	
	if (type == ProductionType.tailor):
		
		#Convert leather to clothes
		for worker in workers:
			var leatherTotalAmt = worker.storage.leather
			var leatherNeeded = 1/LeatherToClothConversion
			
			if (leatherTotalAmt < leatherNeeded): # leatherAmt < 5
				continue
				
			worker.storage.leather -= leatherNeeded
			
			worker.storage.clothes += 1

		debugWorkers()
		print("tailor")
		
	
	elif (type == ProductionType.herder):
		var cowAmt = resources.cows
		
		#Convert to how many items created
		var leatherAmt = cowAmt * CowToLeatherConversion
		
		for worker in workers:
			if (leatherAmt <= 0):
				break
			
			worker.storage.leather += 1
			leatherAmt =- 1
		
		var foodAmt = cowAmt * CowToFoodConversion
		
		for worker in workers:
			if (foodAmt <= 0):
				break
			
			worker.storage.leather += 1
			foodAmt =- 1
		
		debugWorkers()
		print("herder")
	else:
		
		debugWorkers()
		print("barren")

func tradeStage():
	print("trading.....")
	var workers = population.get_children()
	
	for worker in workers:
		continue

func debugSetAllWorkerAmts():
	var workers = population.get_children()
	
	for worker in workers:
		worker.storage.food = 10000
		worker.storage.leather = 1000
		
func debugWorkers():
	var workers = population.get_children()
	
	for worker in workers: 
		worker.printWorkerData()
