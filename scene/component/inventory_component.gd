extends Node
class_name InventoryComponent

@onready var item_refresh_timer: Timer = %ItemRefreshTimer

@export var item_pool: Array[Item]
@export var item_count: int = 5

var inventory = Inventory.new()


func _ready():
	init_inventory()
	item_refresh_timer.timeout.connect(on_item_refresh_timeout)
	
	
func _process(delta):
	if Input.is_action_just_pressed("debut_print_inventory"):
		print(inventory.storage)
		var item = inventory.get_random_item()
		if item == null:
			return
		inventory.remove_item(item)


func init_inventory():
	inventory.add_gold(9999999)
	add_items_from_pool()
	

func add_items_from_pool():
	if item_pool == null || item_pool.is_empty():
		return

	for item_index in item_count:
		var item = item_pool.pick_random()
		inventory.add_item(item)
		
		
func refresh_items():
	if item_pool == null || item_pool.is_empty():
		return
		
	inventory.remove_all_items()
	add_items_from_pool()
	

func on_item_refresh_timeout():
	refresh_items()
