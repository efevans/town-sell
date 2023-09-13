extends Node

signal gold_changed(new_amount: int, original_amount: int, amount_changed: int)

var storage: Dictionary = {
	"gold": 5000,
	"items": {}
#	"items": {"sword": {"quantity": 1,
#			"item_resource": item}}
}


func _process(delta):
	if Input.is_action_just_pressed("debut_print_inventory"):
		print(storage)
		
		
func get_gold():
	return storage["gold"]
	

func add_gold(amount: int):
	var original_amount = get_gold()
	storage["gold"] += amount
	var changed = get_gold() - original_amount
	gold_changed.emit(get_gold(), original_amount, changed)
		

	
func subtract_gold(amount: int):
	add_gold(-amount)
	
	
func has_item(item: Item):
	return storage["items"].has(item.id)


func add_item(item: Item):
	if !storage["items"].has(item.id):
		storage["items"][item.id] = {
			"quantity": 0,
			"item_resource": item
		}
	storage["items"][item.id]["quantity"] += 1


func remove_item(item: Item):
	if storage["items"].has(item.id):
		storage["items"][item.id]["quantity"] -= 1
		if storage["items"][item.id]["quantity"] <= 0:
			var items_dict = storage["items"] as Dictionary
			items_dict.erase(item.id)
