extends Node

# Child Scripts
var workerMovementScript : Node
var familyStageManagementScript : Node
var familySupportFunctionsScript : Node

var familes; 
var workers;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	workerMovementScript = $WorkerMovement
	familyStageManagementScript = $FamilyStageManagment
	familySupportFunctionsScript = $FamilySupportFunctions
	
	familes = familySupportFunctionsScript.getAllFamiles($"../../FamilyNodes")
	workers = familySupportFunctionsScript.getAllWorkers(familes)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# Handle all worker position updates
	workerMovementScript.workerMovement(workers, delta)
	
	# Handles all the family state updates, worker state updates, and state updates
	familyStageManagementScript.processStage(familes, workers)
