extends PanelContainer
class_name ShopLineItem

signal selected(line_item: ShopLineItem)

const default_theme: String = "PanelContainerLineItem"
const in_focus_theme: String = "PanelContainerLineItemSelected"

var item: Item

# Called when the node enters the scene tree for the first time.
func _ready():
	focus_entered.connect(on_focus_entered)
	focus_exited.connect(on_focus_exited)
	
	
func set_item(new_item: Item):
	item = new_item
	update_labels()
	
	
func update_labels():
	%ItemName.text = item.name
	%Price.text = str(item.base_price) + "c"
	
func on_focus_entered():
	theme_type_variation = in_focus_theme
	selected.emit(self)
	print("I'm in focus")
	
	
func on_focus_exited():
	theme_type_variation = default_theme
	print("I'm out of focus")
