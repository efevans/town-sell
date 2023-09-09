extends CanvasLayer

const cursor_offset = Vector2(-22, 6)

@onready var item_container = %ItemContainer
@onready var animation_player = $AnimationPlayer
@onready var cursor_animation_player = $CursorAnimationPlayer
@onready var cursor_parent = %CursorParent
@onready var move_cursor_audio_player = $MoveCursorAudioPlayer

var cursor_pointing_at_line_item = false
var current_line_item_in_focus: PanelContainer
var test_item = preload("res://resources/item/items/fire_sword/fire_sword.tres")


# Called when the node enters the scene tree for the first time.
func _ready():
#	for child in item_container.get_children():
#		child.queue_free()
	play_in()
	if item_container.get_child_count() > 0:
		for line_item in item_container.get_children() as Array[ShopLineItem]:
			line_item.set_item(test_item)
			line_item.selected.connect(on_line_item_selected)
		
		var line_item = item_container.get_child(0) as ShopLineItem
		Callable(line_item.grab_focus).call_deferred()
		
		
func _process(delta):
	if Input.is_action_just_pressed("interact"):
		try_buy_focused_item()
		

func try_buy_focused_item():
	var item = current_line_item_in_focus.item
	if Inventory.get_gold() < item.base_price:
		return false
		
	buy_item(item)
	return true
		
		
func buy_item(item: Item):
	print("buying item " + str(current_line_item_in_focus))
	$BuyItemAudioPlayer.play()
	Inventory.subtract_gold(item.base_price)
	Inventory.add_item(item)


func play_in():
	animation_player.play("in")
	
	
func close():
	animation_player.play_backwards("in")
	await animation_player.animation_finished
	queue_free()
	

func get_cursor_position_for_line_item(line_item: ShopLineItem):
	return line_item.global_position + cursor_offset
	
	
func move_cursor_to_line_item(line_item: ShopLineItem):
	print("selected line item at " + str(line_item.global_position))
	var target_position = get_cursor_position_for_line_item(line_item)
	var tween = create_tween()
	tween.tween_property(cursor_parent, "global_position", target_position, 0.1)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	

func on_line_item_selected(line_item: ShopLineItem):
	current_line_item_in_focus = line_item
	move_cursor_audio_player.play()
	move_cursor_to_line_item(line_item)
