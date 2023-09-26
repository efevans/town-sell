extends Node
class_name TollGateComponent

@export var gate_strings: SingleChoiceMenuString
@export var gate: Gate
@export var gate_fee: int = 5000
@export var single_choice_component: SingleChoiceMenuComponent


func _ready():
	try_get_gate()
	set_text()
	single_choice_component.selected.connect(on_choice_selected)
	
	
func set_text():
	var title = gate_strings.title.format({"gate_fee": str(gate_fee)})
	single_choice_component.set_title_and_label(title, gate_strings.button_text)
	
	
func try_get_gate():
	if gate != null:
		return
	var parent = get_parent()
	assert(parent is Gate)
	gate = parent
	
	
func try_open_gate():
	if PlayerInventory.inventory.get_gold() >= gate_fee:
		PlayerInventory.inventory.subtract_gold(gate_fee)
#		gate.open()
		GameEvents.emit_gate_opened(gate)


func on_choice_selected():
	try_open_gate()
