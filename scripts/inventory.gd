class_name Inventory

signal gold_changed(new_amount: int, original_amount: int, amount_changed: int)
signal item_added(item: Item)
signal item_removed(item: Item)

var storage: Dictionary = {
	"gold": 400,
	"items": {}
#	"items": {"sword": {"quantity": 1,
#			"item_resource": item}}
}


func set_gold(amount: int):
	storage["gold"] = amount
	

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
	
	
func get_item_count(item: Item):
	if !has_item(item):
		return 0
	return storage["items"][item.id]["quantity"]
	
	
func get_random_item() -> Item:
	var rand = storage["items"].keys().pick_random()
	if rand == null:
		return
	return storage["items"][rand]["item_resource"]
	
	
func is_empty():
	return storage["items"].is_empty()


func add_item(item: Item):
	if !storage["items"].has(item.id):
		storage["items"][item.id] = {
			"quantity": 0,
			"item_resource": item
		}
	storage["items"][item.id]["quantity"] += 1
	item_added.emit(item)


func remove_item(item: Item):
	if storage["items"].has(item.id):
		storage["items"][item.id]["quantity"] -= 1
		if storage["items"][item.id]["quantity"] <= 0:
			var items_dict = storage["items"] as Dictionary
			items_dict.erase(item.id)
		item_removed.emit(item)
