class_name TradeLimits
extends Resource

# Low and high value for a specific resource
@export var low: float = 0.0
@export var high: float = 0.0

# Optional: Constructor for direct initialization
func _init(p_low: float = 0.0, p_high: float = 0.0):
	low = p_low
	high = p_high
