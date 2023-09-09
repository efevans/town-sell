extends Node

var storage: Dictionary = {
	"gold": 500,
	"items": {}
#	"items": {"sword": {"quantity": 1}}
}


func _process(delta):
	if Input.is_action_just_pressed("debut_print_inventory"):
		print(storage)
		
		
func get_gold():
	return storage["gold"]
	
	
func subtract_gold(amount: int):
	storage["gold"] -= amount


func add_item(item: Item):
	if !storage["items"].has(item.id):
		storage["items"][item.id] = {"quantity": 0}
	storage["items"][item.id]["quantity"] += 1
	
