extends PanelContainer

@onready var gold_label = %GoldLabel


func _ready():
	Inventory.gold_changed.connect(on_gold_changed)
	
	
func set_gold():
	var gold = Inventory.get_gold()
	set_gold_with_amount(gold)
	
	
func set_gold_with_amount(amount: int):
	gold_label.text = str(amount) + GameStrings.GOLD_SUFFIX
	
	
func on_gold_changed(new_amount: int):
	set_gold_with_amount(new_amount)
