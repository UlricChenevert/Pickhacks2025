extends Node

# storage of an economy

var player_coins: int = 1000
var player_inventory: Array = []
var asset_inventory: Dictionary = {}

# function to sell items (add coins to your bank)
func sell_items(worker: Node, item_name: String, price: int) -> void:
	if item_name in player_inventory:
		player_inventory.erase(item_name)
		player_coins += price
		print("Sold", item_name, price, "coins. Total coins: ", player_coins)
	else:
		print("Item was not sold.")
		
# function to buy an item (deducts coinS)
func buy_item(worker: Node, item_name: String, price: int) -> void:
	if player_coins >= price:
		player_coins -= price
		player_inventory.append(item_name)
		print("Brought", item_name, "for", price, "coins. Remainiing coins: ", player_coins)
	else:
		print("Item was not purchased.")

# function to remove / add in inventory
func has_item(item: String) -> bool:
		return asset_inventory.get(item, 0) > 0

func add_to_inventory(item: String) -> void:
		asset_inventory[item] = asset_inventory.get(item, 0) + 1
