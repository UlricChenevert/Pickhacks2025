extends Node

enum TradeStages {none = 0, travelToMarket = 1, barter = 2, travelHome = 3}

@onready var workerMovementScript = $"../../WorkerMovement"

@export var tradeStage : TradeStages = TradeStages.none
@export var tradeTilePosition : Vector2 = Vector2 (0,0)

func processTradeStage(familes : Array[Family], workers : Array[Worker]) -> bool:
	var nextGameStage = false
	# Overites all worker movement with target at trade tile, then start travelling
	if (tradeStage == TradeStages.none):
		for worker in workers:
			var newTargetPosition = Vector2(
				randi_range(-worker.moveRange + tradeTilePosition.x, worker.moveRange + tradeTilePosition.x), 
				randi_range(-worker.moveRange + tradeTilePosition.y, worker.moveRange + tradeTilePosition.y)
			)
			
			workerMovementScript.setTarget(worker, newTargetPosition)
		
		tradeStage = TradeStages.travelToMarket
	elif (tradeStage == TradeStages.travelToMarket):
		tradeStage = TradeStages.barter
		
		#If anyone does not arrive this cycle, then don't start trading
		for worker in workers:
			if (worker.movementState == worker.MovementState.walk):
				tradeStage = TradeStages.travelToMarket	
				
	elif (tradeStage == TradeStages.barter):
		var nextStage = true
		
		# If anyone isn't satisfied, then don't start going home
		for family in familes:
			barter(family, familes)
			
			if (family.familyTradeStage == Family.FamilyTradeStates.notSatified):
				nextStage = false
				
		if (nextStage):
			tradeStage = TradeStages.travelHome
			
			for worker in workers:
				workerMovementScript.setTarget(worker, worker.homePosition)
	
	elif (tradeStage == TradeStages.travelHome):
		var nextStage = true
		
		for worker in workers:
			#If anyone does not arrive this cycle, then don't finish this stage
			if (worker.movementState == worker.MovementState.walk):
				nextStage = false
		
		# Once everyone home, set to none and increment game stage
		if (nextStage):
			tradeStage = TradeStages.none
			nextGameStage = true
		
	return nextGameStage

func barter(family : Family, familes : Array[Family]):
	if (family.familyTradeStage == family.FamilyTradeStates.none):
		# If they are low on supplies, then attempt to buy
		print("TODO: Implement bartering!")
		family.familyTradeStage = Family.FamilyTradeStates.satisfied
		
		return
	elif (family.familyTradeStage == Family.FamilyTradeStates.notSatified):
		# If they bought all they need then they are satified
		
		return
		
	elif (family.familyTradeStage == Family.FamilyTradeStates.satisfied):
		# If they are low on supplies, then attempt to buy
		
		return
