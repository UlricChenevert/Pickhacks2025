extends Node2D

enum ProductionType {barren = 0, herder = 1, tailor = 2}

@onready var population = $Workers # Worker[]
@onready var resources = $Resources # Either leather or cows
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
	productionStage(delta)

func debugSetAllWorkerAmts():
	var workers = population.get_children()
	
	for worker in workers:
		worker.storage.food = 10000
		worker.storage.leather = 1000
		

func consumeStage(delta : float):
	var workers = population.get_children()
	
	for worker in workers:
		worker.decayClothes(delta)
		worker.decayFood(delta)

func productionStage(delta : float):
	var workers = population.get_children()
	
	if (type == ProductionType.tailor):
		#var commonLeatherAmt = 0
		var goodsAmt = 0
		#Convert to how many items created
		for worker in workers:
			var leatherAmt = worker.storage.leather
			var leatherNeeded = round(leatherAmt*LeatherToClothConversion)
			
			worker.storage.leather -= leatherNeeded
			
			goodsAmt += leatherNeeded
			
		print(goodsAmt)
		
		#Distribute
		for worker in workers:
			if (goodsAmt <= 0):
				break
			
			worker.storage.clothes += 1
			goodsAmt =- 1
			
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
		
		print("herder")
	else:
		print("barren")

func tradeStage(delta : float):
	var workers = population.get_children()
	
	for worker in workers:
		continue
	


func produceHerder():
	pass
	
func produceTailor():
	pass
