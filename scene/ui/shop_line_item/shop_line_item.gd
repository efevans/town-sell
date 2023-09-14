extends PanelContainer
class_name ShopLineItem

signal selected(line_item: ShopLineItem)

const default_theme: String = "PanelContainerLineItem"
const in_focus_theme: String = "PanelContainerLineItemSelected"

var item: Item
var quantity: int

# Called when the node enters the scene tree for the first time.
func _ready():
	focus_entered.connect(on_focus_entered)
	focus_exited.connect(on_focus_exited)
	
	
func set_item(new_item: Item, new_quantity: int):
	item = new_item
	quantity = new_quantity
	update_labels()
	
	
func update_labels():
	%ItemName.text = item.name
	%Quantity.text = GameStrings.QUANTITY_PREFIX + str(quantity)
	%Price.text = str(item.base_price) + GameStrings.GOLD_SUFFIX
	
	
func on_focus_entered():
	print("I'm in focus")
	theme_type_variation = in_focus_theme
	selected.emit(self)
	
	
func on_focus_exited():
	print("I'm out of focus")
	theme_type_variation = default_theme
