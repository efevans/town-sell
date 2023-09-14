extends CanvasLayer

const cursor_offset = Vector2(-22, 6)

@onready var item_container = %ItemContainer
@onready var animation_player = $AnimationPlayer
@onready var cursor_animation_player = $CursorAnimationPlayer
@onready var cursor_parent = %CursorParent
@onready var move_cursor_audio_player = $MoveCursorAudioPlayer

@export var test_items: Array[Item]

var shop_line_item_scene: PackedScene = preload(GameStrings.SHOP_LINE_ITEM_SCENE_PATH)
var current_line_item_in_focus: PanelContainer

var inventory: Inventory = Inventory.new()


func _ready():
	play_in()
	init_inventory()
		
		
func _process(delta):
	if Input.is_action_just_pressed("interact"):
		try_buy_focused_item()
		
		
func init_inventory():
	for child in item_container.get_children():
		child.queue_free()
		
	var first_line_item: ShopLineItem
	for item_index in 4:
		var line_item_instance = shop_line_item_scene.instantiate() as ShopLineItem
		item_container.add_child(line_item_instance)
		var item = test_items.pick_random()
		line_item_instance.set_item(item, 2)
		line_item_instance.selected.connect(on_line_item_selected)
		
		if item_index == 0:
			first_line_item = line_item_instance
		
	Callable(grab_focus_after_break.bind(first_line_item)).call_deferred()
#	Callable(first_line_item.grab_focus).call_deferred()
	

func grab_focus_after_break(next_focus_item: ShopLineItem):
	await get_tree().create_timer(0.01).timeout
	next_focus_item.grab_focus()
		

func try_buy_focused_item():
	var item = current_line_item_in_focus.item
	if PlayerInventory.inventory.get_gold() < item.base_price:
		return false
		
	buy_item(item)
	return true
		
		
func buy_item(item: Item):
	print("buying item " + str(current_line_item_in_focus))
	$BuyItemAudioPlayer.play()
	PlayerInventory.inventory.subtract_gold(item.base_price)
	PlayerInventory.inventory.add_item(item)


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
