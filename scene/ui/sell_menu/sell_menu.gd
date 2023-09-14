extends CanvasLayer

const cursor_offset = Vector2(-22, 6)

@onready var item_container = %ItemContainer
@onready var animation_player = $AnimationPlayer
@onready var cursor_animation_player = $CursorAnimationPlayer
@onready var cursor_parent = %CursorParent
@onready var move_cursor_audio_player = $MoveCursorAudioPlayer

var shop_line_item_scene: PackedScene = preload(GameStrings.SHOP_LINE_ITEM_SCENE_PATH)
var current_line_item_in_focus: ShopLineItem

var inventory: Inventory = PlayerInventory.inventory
var tracked_inventory: Inventory


# Called when the node enters the scene tree for the first time.
func _ready():
	play_in()
	update_shop_with_player_items()
		
		
func _process(delta):
	if Input.is_action_just_pressed("interact"):
		try_sell_focused_item()
		
		
func set_inventory_to_track(new_inventory: Inventory):
	tracked_inventory = new_inventory
		
		
func update_shop_with_player_items():
	for child in item_container.get_children():
		child.queue_free()
		
	for item in PlayerInventory.inventory.storage["items"]:
		var line_item_instance = shop_line_item_scene.instantiate() as ShopLineItem
		item_container.add_child(line_item_instance)
		line_item_instance.set_inventory_to_track(inventory)
		line_item_instance.set_item(PlayerInventory.inventory.storage["items"][item]["item_resource"])
		line_item_instance.selected.connect(on_line_item_selected)
		
	if item_container.get_child_count() > 0:
		var line_item = item_container.get_child(0) as ShopLineItem
		Callable(line_item.grab_focus).call_deferred()
	else:
		cursor_parent.visible = false
		

func try_sell_focused_item():
	if current_line_item_in_focus == null:
		return false
	
	var item = current_line_item_in_focus.item as Item
	sell_item(item)
	
	return true
		
		
func sell_item(item: Item):
	print("buying item " + str(current_line_item_in_focus))
	$BuyItemAudioPlayer.play()
	PlayerInventory.inventory.remove_item(item)
	current_line_item_in_focus.set_item(item, )
	PlayerInventory.inventory.add_gold(item.base_price)
	
	if !PlayerInventory.inventory.has_item(item):
		remove_item_from_menu_and_update_focus()
		

func remove_item_from_menu_and_update_focus():
	var current_line_item_index = item_container.get_children().find(current_line_item_in_focus)
	
	var items_in_shop = item_container.get_child_count()
	print("before selling, " + str(items_in_shop) + " items in shop")
	if items_in_shop == 1:
		cursor_parent.visible = false
	else:
		var next_focus_item
		if current_line_item_index == items_in_shop - 1:
			# Last item, set focus to previous item
			next_focus_item = item_container.get_child(current_line_item_index - 1) as ShopLineItem
		else:
			# Not last item, set focus to next item
			next_focus_item = item_container.get_child(current_line_item_index + 1) as ShopLineItem
			
		Callable(grab_focus_after_break.bind(next_focus_item)).call_deferred()
#		Callable(next_focus_item.grab_focus).call_deferred()
		
	print("removing sold item from shop")
	current_line_item_in_focus.queue_free()


func grab_focus_after_break(next_focus_item: ShopLineItem):
	await get_tree().create_timer(0.01).timeout
	next_focus_item.grab_focus()


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
