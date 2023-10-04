extends CanvasLayer

@onready var numerator_animation_player = %NumeratorAnimationPlayer
@onready var denominator_animation_player = %DenominatorAnimationPlayer
@onready var numerator = %Numerator
@onready var separator = %Separator
@onready var denominator = %Denominator


func _ready():
	PlayerInventory.inventory.item_added.connect(on_inventory_changed)
	PlayerInventory.inventory.item_removed.connect(on_inventory_changed)
	PlayerInventory.inventory.failed_to_add_item_due_to_insufficient_storage\
	.connect(on_insufficient_storage)
	update_labels()
	
	
func update_labels():
	var new_numerator = str(PlayerInventory.inventory.get_storage_count())
	var new_denominator = str(PlayerInventory.inventory.max_storage_size)
	
	if numerator.text != new_numerator:
		numerator_animation_player.play("jiggle")
		numerator.text = new_numerator
		
	if denominator.text != new_denominator:
		denominator_animation_player.play("jiggle")
		denominator.text = new_denominator


func on_inventory_changed(_item: Item):
	update_labels()
	
	
func on_insufficient_storage():
	numerator_animation_player.play("jiggle_color")
	
