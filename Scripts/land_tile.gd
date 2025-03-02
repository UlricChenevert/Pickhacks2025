extends Node2D

enum ProductionType {herder = 0, tailor = 1}

var population = "metadata/Population" # Worker[]
var resources = "metadata/Resources" # Either leather or cows
var type : ProductionType = ProductionType.herder
