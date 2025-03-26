extends Node

#Child Script
@onready var tradeScript = $Trade
@onready var produceScript = $Produce
@onready var consumeScript = $Consume
@onready var buyScript = $Buy

enum GameStages {consume = 0, produce = 1, trade = 2, buy = 3}

@export var gameStage : GameStages = GameStages.consume


func processStage(familes : Array[Family], workers : Array[Worker]):
	if (gameStage == GameStages.consume):
		consumeScript.processConsumeStage(familes, workers)
		
		gameStage = GameStages.produce
		
	elif (gameStage == GameStages.produce):
		produceScript.processProductionStage(familes, workers)
		
		gameStage = GameStages.trade
		
	elif (gameStage == GameStages.trade):
		var nextStage = tradeScript.processTradeStage(familes, workers)
		
		if (nextStage):
			gameStage = GameStages.buy
		
	elif (gameStage == GameStages.buy):
		for family in familes:
			buyScript.buy(family)
			
		gameStage = GameStages.consume
