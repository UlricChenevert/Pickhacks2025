extends Node2D

class_name Family

enum GameStages {consume = 0, produce = 1, trade = 2, buy = 3, done = 4}
enum FamilyTradeStates {none = 0, notSatified = 1, satisfied = 2}
enum FamilyProfession {none = 0, herder = 1, tailor = 2}

@export var familyTradeStage : FamilyTradeStates = FamilyTradeStates.none
@export var familyStage : GameStages = GameStages.consume

@export var familyProfession : FamilyProfession = FamilyProfession.none

@export var homePosition = global_position

# Just going to have all possible resources here, but I can and will expand upon this later
@export var familySize = 1
@export var food = 100
@export var clothes = 1
@export var leather = 0
@export var cows = 0

@export var foodRates : TradeLimits = TradeLimits.new(0,0)
@export var clothesRates : TradeLimits = TradeLimits.new(0,0)
@export var leatherRates : TradeLimits = TradeLimits.new(0,0)
