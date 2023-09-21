extends Node
class_name InventoryComponent

@export var item_pool: Array[Item]
@export var item_count: int = 5

var inventory = Inventory.new()


func _ready():
	init_inventory()


func init_inventory():
	if item_pool == null || item_pool.is_empty():
		return
		
	for item_index in item_count:
		var item = item_pool.pick_random()
		inventory.add_item(item)
