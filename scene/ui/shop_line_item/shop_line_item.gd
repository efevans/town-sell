extends PanelContainer
class_name ShopLineItem

signal selected(line_item: ShopLineItem)

const default_theme: String = "PanelContainerLineItem"
const in_focus_theme: String = "PanelContainerLineItemSelected"

var item: Item
var tracked_inventory: Inventory

# Called when the node enters the scene tree for the first time.
func _ready():
	focus_entered.connect(on_focus_entered)
	focus_exited.connect(on_focus_exited)
	
	
func set_inventory_to_track(inventory: Inventory):
	tracked_inventory = inventory
	tracked_inventory.item_added.connect(on_tracked_inventory_item_added)
	tracked_inventory.item_removed.connect(on_tracked_inventory_item_removed)
	
	
func set_item(new_item: Item):
	item = new_item
	update_labels()
	
	
func update_labels():
	%ItemName.text = item.name
	%Quantity.text = GameStrings.QUANTITY_PREFIX + str(tracked_inventory.get_item_count(item))
	%Price.text = str(item.base_price) + GameStrings.GOLD_SUFFIX
	
	
func on_focus_entered():
	print("I'm " + str(self) + " in focus")
	theme_type_variation = in_focus_theme
	selected.emit(self)
	
	
func on_focus_exited():
	print("I'm out of focus")
	theme_type_variation = default_theme
	
	
func on_tracked_inventory_item_added(added_item: Item):
	if added_item.id == item.id:
		update_labels()
	
	
func on_tracked_inventory_item_removed(removed_item: Item):
	if removed_item.id == item.id:
		update_labels()
