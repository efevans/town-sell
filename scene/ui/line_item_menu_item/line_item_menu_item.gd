extends PanelContainer
class_name LineItemMenuItem

signal selected(line_item: LineItemMenuItem)

const default_theme: String = "PanelContainerLineItem"
const in_focus_theme: String = "PanelContainerLineItemSelected"

@onready var item_name_label: Label = %ItemName
@onready var quantity_label: Label = %Quantity
@onready var price_label: Label = %Price
@onready var percentage_label = %Percentage

var item: Item
var price: int
var tracked_inventory: Inventory
var type_controller


func _ready():
	focus_entered.connect(on_focus_entered)
	focus_exited.connect(on_focus_exited)
	
	
func set_inventory_to_track(inventory: Inventory):
	tracked_inventory = inventory
	tracked_inventory.item_added.connect(on_tracked_inventory_item_added)
	tracked_inventory.item_removed.connect(on_tracked_inventory_item_removed)
	
	
func set_pricer_to_track(item_pricer: ItemPricer):
	pass
	
	
func set_item(new_item: Item):
	item = new_item
	update_labels()
	
	
func set_controller(controller):
	type_controller = controller
	type_controller.item_price_rates_changed.connect(on_price_rates_changed)
	update_labels()
	
	
func update_price():
	if type_controller == null:
		price = item.base_price
		return
	price = type_controller.get_price_for_item(item)
	
	
func update_labels():
	update_price()
	item_name_label.text = item.name
	quantity_label.text = GameStrings.QUANTITY_PREFIX + str(tracked_inventory.get_item_count(item))
	price_label.text = get_price_label_text()
	price_label.modulate = get_color_for_price_label()
	percentage_label.text = get_percentage_label_text()
	percentage_label.modulate = price_label.modulate
	
	
func get_price_label_text():
	return str(price) + GameStrings.GOLD_SUFFIX
	
	
func get_percentage_label_text():
	return "(" + str(roundi(100.0 * price / item.base_price)) + "%)"
	
	
func get_color_for_price_label():
	if type_controller == null:
		return Color.WHITE
	return type_controller.get_color_for_price_label(item)
	
	
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
		
		
func on_price_rates_changed():
	update_labels()
