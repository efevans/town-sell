class_name ItemPricer

signal item_price_rates_changed

const RATE_MIN = 0.6
const RATE_MAX = 1.3

var item_price_rates: Dictionary = {
#	"item.id": rate (i.e. 0.8 or 1.2) ex. flame_sword: 0.94
}


func get_rate_for_item(item: Item) -> float:
	if item_price_rates.has(item.id):
		return item_price_rates[item.id]
	return 1.0
	
	
func randomize_rates():
	for item_id in item_price_rates:
		item_price_rates[item_id] = randf_range(RATE_MIN, RATE_MAX)
	item_price_rates_changed.emit()


static func get_random_pricer() -> ItemPricer:
	var pricer = ItemPricer.new()
	var item_ids: Array[String] = get_all_item_ids()
	
	for item_id in item_ids:
		var rate = randf_range(0.6, 1.4)
		pricer.add_item(item_id, rate)
		
	return pricer
	
	
static func get_all_item_ids() -> Array[String]:
	var ids: Array[String] = []
	
	var dir = DirAccess.open("res://resources/item/items/")
	if dir:
		dir.list_dir_begin()
		var dir_name = dir.get_next()
		while dir_name != "":
			ids.append(dir_name)
			dir_name = dir.get_next()
			
	return ids


func add_item(item_id: String, rate: float):
	item_price_rates[item_id] = rate
