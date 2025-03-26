extends Node

@export var cowFoodProduction = 2
@export var cowLeatherProduction = 1
@export var leatherToClothes = 5

@onready var workerMovementScript = $"../../WorkerMovement"

func processProductionStage(familes : Array[Family], workers : Array[Worker]):
	for worker in workers:
		workerMovementScript.setRandomTarget(worker)
	
	for family in familes:
		produce(family)

func produce(family : Family):
	if (family.familyProfession == family.FamilyProfession.herder):
		family.food += cowFoodProduction * family.cows
		family.leather += cowLeatherProduction * family.cows
		
	elif (family.familyProfession == family.FamilyProfession.tailor):
		var MaxClothingProduction = floor(family.leather/leatherToClothes)
		var MaxLeatherUse = MaxClothingProduction * leatherToClothes
		
		family.leather -= MaxLeatherUse
		family.clothes += MaxClothingProduction
		
	#Next stage
	family.familyStage = Family.GameStages.trade
	
