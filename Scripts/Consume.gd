extends Node

@export var foodDecayPerPerson = 1
@export var clothingDecayPerPerson = 0.05

@onready var workerMovementScript = $"../../WorkerMovement"

func processConsumeStage(familes : Array[Family], workers : Array[Worker]):
	for worker in workers:
		workerMovementScript.setRandomTarget(worker)
	
	for family in familes:
		consume(family)

func consume(family : Family):
	family.food -= foodDecayPerPerson * family.familySize
	family.clothes -= clothingDecayPerPerson * family.familySize
	
	#Next stage
	family.familyStage = Family.GameStages.produce
