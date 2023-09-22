class_name PlayerSellInteractionController

static var good_color = Color(1, 0.191, 0.176) # blue
static var bad_color = Color(0.342, 0.545, 0.926) # red
static var neutral_color = Color(1, 1, 1) # white

var buyer_inventory: Inventory
var seller_inventory: Inventory
var item_pricer: ItemPricer


func init(owner: NPC):
	buyer_inventory = owner.get_inventory()
	seller_inventory = PlayerInventory.inventory
	item_pricer = owner.get_item_pricer()
	return self
	
	
func get_instructions() -> String:
	return GameStrings.LINE_ITEM_MENU_SELLING_INSTRUCTIONS


func get_buyer_inventory() -> Inventory:
	return buyer_inventory


func get_seller_inventory() -> Inventory:
	return seller_inventory
	
	
func get_price_for_item(item: Item):
	if item_pricer == null:
		return item.base_price
		
	var price = item.base_price * item_pricer.get_rate_for_item(item)
	return roundi(price)
	

func get_color_for_price_label(item: Item):
	if item_pricer == null:
		return neutral_color
	var rate = item_pricer.get_rate_for_item(item)
	if rate > 1.0:
		return good_color
	elif rate < 1.0:
		return bad_color
	return neutral_color
	
	
func interact(line_item: LineItemMenuItem):
	if buyer_inventory.get_gold() < line_item.price:
		return false

	buyer_inventory.subtract_gold(line_item.price)
	seller_inventory.add_gold(line_item.price)
	seller_inventory.remove_item(line_item.item)
	buyer_inventory.add_item(line_item.item)
	return true
