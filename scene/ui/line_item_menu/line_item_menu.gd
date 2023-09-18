extends MarginContainer
class_name LineItemMenu

enum Type {PLAYER_BUY, PLAYER_SELL}

const CURSOR_OFFSET = Vector2(-22, 6)

@onready var interact_line_item_audio_player = $InteractLineItemAudioPlayer
@onready var item_container = %ItemContainer
@onready var cursor_parent = %CursorParent
@onready var move_cursor_audio_player = $MoveCursorAudioPlayer

var shop_line_item_scene: PackedScene = preload(GameStrings.LINE_ITEM_MENU_ITEM_SCENE_PATH)
var current_line_item_in_focus: LineItemMenuItem

var buyer_inventory: Inventory

var type_controller


#func setup() -> LineItemMenu:
#	setup_items()
#	return self


func _ready():
	setup_items()
	pass
		
		
func _process(delta):
	if Input.is_action_just_pressed("interact"):
		try_interact_focused_item()
	
	
func set_type_controller(controller):
	type_controller = controller
	type_controller.seller_inventory.item_added.connect(on_item_added_to_inventory)
	type_controller.seller_inventory.item_removed.connect(on_item_removed_from_inventory)
	
	
func setup_items():
	for child in item_container.get_children():
		child.queue_free()
		
	if type_controller == null || type_controller.seller_inventory.is_empty():
		cursor_parent.visible = false
		return
		
	var first_line_item: LineItemMenuItem = null
	for item in type_controller.seller_inventory.storage["items"]:
		var line_item_instance = add_line_item(type_controller.seller_inventory.storage["items"][item]["item_resource"])
		
		if first_line_item == null:
			first_line_item = line_item_instance
		
	Callable(grab_focus_after_break.bind(first_line_item)).call_deferred()
	

func try_interact_focused_item():
	print("interacted with line item!")
	if current_line_item_in_focus == null:
		return false
		
	var success = type_controller.interact(current_line_item_in_focus.item)
	if success:
		interact_line_item_audio_player.play()
	

func add_line_item(item: Item):
	var line_item_instance = shop_line_item_scene.instantiate() as LineItemMenuItem
	item_container.add_child(line_item_instance)
	line_item_instance.set_inventory_to_track(type_controller.seller_inventory)
	line_item_instance.set_item(item)
	line_item_instance.selected.connect(on_line_item_selected)
	return line_item_instance


func grab_focus_after_break(next_focus_item: LineItemMenuItem):
	await get_tree().create_timer(0.02).timeout
	next_focus_item.grab_focus()
	
	
func remove_item_and_update_focus(line_item: LineItemMenuItem):
	var item_index = item_container.get_children().find(line_item)
	
	var items_in_shop = item_container.get_child_count()
	print("before selling, " + str(items_in_shop) + " items in shop")
	if items_in_shop == 1:
		cursor_parent.visible = false
	elif current_line_item_in_focus != line_item:
		Callable(grab_focus_after_break.bind(current_line_item_in_focus)).call_deferred()
	else:
		var next_focus_item
		if item_index == items_in_shop - 1:
			# Last item, set focus to previous item
			next_focus_item = item_container.get_child(item_index - 1) as LineItemMenuItem
		else:
			# Not last item, set focus to next item
			next_focus_item = item_container.get_child(item_index + 1) as LineItemMenuItem
			
		Callable(grab_focus_after_break.bind(next_focus_item)).call_deferred()
		
	print("removing sold item from shop")
	line_item.queue_free()
		
	

func get_cursor_position_for_line_item(line_item: LineItemMenuItem):
	return line_item.global_position + CURSOR_OFFSET
	
	
func move_cursor_to_line_item(line_item: LineItemMenuItem):
	print("selected line item at " + str(line_item.global_position))
	var target_position = get_cursor_position_for_line_item(line_item)
	var tween = create_tween()
	tween.tween_property(cursor_parent, "global_position", target_position, 0.1)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	

func on_line_item_selected(line_item: LineItemMenuItem):
	if current_line_item_in_focus == line_item:
		return
	
	current_line_item_in_focus = line_item
	move_cursor_audio_player.play()
	move_cursor_to_line_item(line_item)
	
	
func on_item_added_to_inventory(item: Item):
	var item_already_tracked = item_container.get_children().any(func (line_item: LineItemMenuItem):
		if line_item.item.id == item.id:
			return true
		return false
	)
	
	if item_already_tracked:
		return
		
	add_line_item(item)
	

func on_item_removed_from_inventory(item: Item):
	var item_still_in_stock = type_controller.seller_inventory.has_item(item)
	
	if item_still_in_stock:
		return
	
	var line_item_for_depleted_item: LineItemMenuItem = null
	for line_item in item_container.get_children() as Array[LineItemMenuItem]:
		if line_item.item.id == item.id:
			line_item_for_depleted_item = line_item
			break
	
	if line_item_for_depleted_item == null:
		return
		
	# Remove it, and update the focus line item and position if needed
	remove_item_and_update_focus(line_item_for_depleted_item)
