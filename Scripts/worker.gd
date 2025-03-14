extends Node2D

var clothingDecay = 0.0001
var foodDecay = 0.1
enum Professions {Herder = 1, Tailor = 2}

@export var homeTileID = ""

@onready var storage = $Storage
@onready var values = $GoodValues

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	storage.food = 10
	storage.clothes = 1
	storage.money = 1000
	
	values.clothes.max = 10
	values.clothes.min = 0
	
	values.food.max = 10
	values.food.min = 0
	

func printWorkerData():
	print("Woker { food: " + str(storage.food) + ", clothes: " + str(storage.clothes) + ", money: " + str(storage.money) + " }")

#
## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	decayClothes(delta)
	decayFood(delta)
	
	#print(storage.money)
	#print(storage.clothes)
	#print(storage.food)


func decayClothes(delta: float) -> void:
	storage.clothes -= delta * clothingDecay
	
func decayFood(delta: float) -> void:
	storage.food -= delta * foodDecay
