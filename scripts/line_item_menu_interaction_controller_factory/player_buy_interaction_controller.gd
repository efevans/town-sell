class_name PlayerBuyInteractionController

var buyer_inventory: Inventory
var seller_inventory: Inventory


func init(npc: NPC):
	buyer_inventory = PlayerInventory.inventory
	seller_inventory = npc.inventory
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


#func try_buy_focused_item():
#	if current_line_item_in_focus == null:
#		return false
#
#	var item = current_line_item_in_focus.item
#	if PlayerInventory.inventory.get_gold() < item.base_price:
#		return false
#
#	buy_item(item)
#	return true
#
#
#func buy_item(item: Item):
#	print("buying item " + str(current_line_item_in_focus))
#	$BuyItemAudioPlayer.play()
#	PlayerInventory.inventory.subtract_gold(item.base_price)
#	PlayerInventory.inventory.add_item(item)
#
#	tracked_inventory.remove_item(item)
#	if !tracked_inventory.has_item(item):
#		remove_item_from_menu_and_update_focus()
