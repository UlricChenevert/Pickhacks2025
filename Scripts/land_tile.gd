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

func _process(delta: float) -> void:
	productionStage(delta)

func consumeStage(delta : float):
	var workers = population.get_children()
	
	for worker in workers:
		worker.decayClothes(delta)
		worker.decayFood(delta)

func productionStage(delta : float):
	var workers = population.get_children()
	
	if (type == ProductionType.tailor):
		var leatherAmt = 0
		for worker in workers:
			leatherAmt += worker.getLeather()
		
		#Convert to how many items created
		var goodsAmt = leatherAmt * LeatherToClothConversion
		
		for worker in workers:
			if (goodsAmt <= 0):
				break
			
			worker.storage.clothes += 1
			goodsAmt =- 1
	
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
			
	else:
		print("barren")
		
		
	
	
	#for 
	
	
func tradeStage(delta : float):
	var workers = population.get_children()
	
	for worker in workers:
		continue
	


func produceHerder():
	pass
	
func produceTailor():
	pass
