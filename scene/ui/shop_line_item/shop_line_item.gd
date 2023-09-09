extends PanelContainer

signal selected(line_item: PanelContainer)

const default_theme: String = "PanelContainerLineItem"
const in_focus_theme: String = "PanelContainerLineItemSelected"

# Called when the node enters the scene tree for the first time.
func _ready():
	focus_entered.connect(on_focus_entered)
	focus_exited.connect(on_focus_exited)
	
	
func on_focus_entered():
	theme_type_variation = in_focus_theme
	selected.emit(self)
	print("I'm in focus")
	
	
func on_focus_exited():
	theme_type_variation = default_theme
	print("I'm out of focus")
