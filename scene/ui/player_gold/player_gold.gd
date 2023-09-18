extends CanvasLayer

@onready var gold_label = %GoldLabel
#@export var canvas_layer: CanvasLayer

var floating_text_scene: PackedScene = preload("res://scene/ui/floating_text/floating_text.tscn")


func _ready():
	PlayerInventory.inventory.gold_changed.connect(on_gold_changed)
	update_gold()
	
	
func set_gold_text(amount: int):
	gold_label.text = str(amount) + GameStrings.GOLD_SUFFIX
	
	
func update_gold():
	set_gold_text(PlayerInventory.inventory.get_gold())
	
	
func update_gold_with_animation(new_amount: int, amount_changed: int):
	set_gold_text(new_amount)
	
	if amount_changed == 0:
		return
	
	var floating_text = floating_text_scene.instantiate() as Control
	add_child(floating_text)
	
	floating_text.global_position = gold_label.global_position + gold_label.size - Vector2(0, 10)
	
	var sign_char = "+" if amount_changed > 0 else ""
	var text = sign_char + str(amount_changed) + "G"
	floating_text.start(text)
	
	
func on_gold_changed(new_amount: int, original_amount: int, amount_changed: int):
	update_gold_with_animation(new_amount, amount_changed)
