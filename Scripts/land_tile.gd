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

#var player_coins: int = 1000
#var player_inventory: Array = []
#var worker_inventory: Dictionary = {}
#var worker_name
#
## function to sell items (add coins to your bank)
#func sell_items(worker: Node, item_name: String, price: int) -> void:
	#if item_name in player_inventory:
		#player_inventory.erase(item_name)
		#player_coins += price
		#print("Sold", item_name, price, "coins. Total coins: ", player_coins)
	#else:
		#print("Item was not sold.")
		#
## function to buy an item (deducts coinS)
#func buy_item(worker: Node, item_name: String, price: int) -> void:
	#if player_coins >= price:
		#player_coins -= price
		#player_inventory.append(item_name)
		#print("Brought", item_name, "for", price, "coins. Remainiing coins: ", player_coins)
	#else:
		#print("Item was not purchased.")
#
## function to remove / add in inventory
#func has_item(item: String) -> bool:
		#return worker_inventory.get(item, 0) > 0
#
#func add_to_inventory(item: String) -> void:
		#worker_inventory[item] = worker_inventory.get(item, 0) + 1
#
## Initializs worker inventory
#func worker(worker_name: String) -> void:
	#if worker_name not in worker_inventory:
		#worker_inventory[worker_name] = {}
#
## Get a worker's inventory
#func worker_inventories() -> Dictionary:
	#return GameStorage.get_inventory(worker_name)


func debugSetAllWorkerAmts():
	var workers = population.get_children()
	
	for worker in workers:
		worker.storage.food = 10000
		worker.storage.leather = 1000
		
func debugWorkers():
	var workers = population.get_children()
	
	for worker in workers: 
		worker.printWorkerData()
