class_name PlayerBuyInteractionController

signal item_price_rates_changed

static var good_color = Color(1, 0.623, 0.611)
static var slight_good_color = Color(1, 0.797, 0.766)
static var neutral_color = Color(1, 1, 1)
static var slightly_bad_color = Color(0.804, 0.869, 0.979)
static var bad_color = Color(0.342, 0.545, 0.926)

var buyer_inventory: Inventory
var seller_inventory: Inventory
var item_pricer: ItemPricer


func init(owner: NPC):
	buyer_inventory = PlayerInventory.inventory
	seller_inventory = owner.get_inventory()
	item_pricer = owner.get_item_pricer()
	if item_pricer != null:
		item_pricer.item_price_rates_changed.connect(func(): item_price_rates_changed.emit())
	return self
	
	
func get_instructions() -> String:
	return GameStrings.LINE_ITEM_MENU_BUYING_INSTRUCTIONS


func get_buyer_inventory() -> Inventory:
	return buyer_inventory


func get_seller_inventory() -> Inventory:
	return seller_inventory
	
	
func get_price_for_item(item: Item):
	if item_pricer == null:
		return item.base_price
		
	var price = item.base_price * item_pricer.get_rate_for_item(item)
	return snappedi(price, 5)
	

func get_color_for_price_label(item: Item) -> Color:
	if item_pricer == null:
		return neutral_color
	var rate = item_pricer.get_rate_for_item(item)
	if rate > 1.20:
		return bad_color
	elif rate > 1.05:
		return slightly_bad_color
	elif rate < 0.80:
		return good_color
	elif rate < 0.95:
		return slight_good_color
	return neutral_color
	
	
func interact(line_item: LineItemMenuItem):
	if buyer_inventory.get_gold() < line_item.price || \
	buyer_inventory.max_storage_size < buyer_inventory.get_storage_count() + 1:
		return false

	buyer_inventory.subtract_gold(line_item.price)
	seller_inventory.add_gold(line_item.price)
	seller_inventory.remove_item(line_item.item)
	buyer_inventory.add_item(line_item.item)
	return true
