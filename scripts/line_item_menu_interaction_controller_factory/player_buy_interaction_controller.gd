class_name PlayerBuyInteractionController

var buyer_inventory: Inventory
var seller_inventory: Inventory


func init(owner_inventory: Inventory):
	buyer_inventory = PlayerInventory.inventory
	seller_inventory = owner_inventory
	return self


func get_buyer_inventory() -> Inventory:
	return buyer_inventory


func get_seller_inventory() -> Inventory:
	return seller_inventory


func interact(item: Item):
	if buyer_inventory.get_gold() < item.base_price:
		return false

	buyer_inventory.subtract_gold(item.base_price)
	seller_inventory.add_gold(item.base_price)
	seller_inventory.remove_item(item)
	buyer_inventory.add_item(item)
	return true
