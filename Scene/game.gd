extends Node2D

@onready var timer = $Timer
@onready var tiles = $Tiles.get_children()

var stageIteration = 0
var stageAmt = 2

func _on_timer_timeout() -> void:
	stageIteration += 1
	for tile in tiles:
		if (stageIteration % stageAmt == 0):
			tile.productionStage()
		elif (stageIteration % stageAmt == 1):
			tile.tradeStage()
