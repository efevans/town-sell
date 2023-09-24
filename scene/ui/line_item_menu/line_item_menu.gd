extends MarginContainer
class_name LineItemMenu

enum Type {PLAYER_BUY, PLAYER_SELL, SINGLE_CHOICE_BUY}

const CURSOR_OFFSET = Vector2(-22, 6)

@onready var instructions: Label = %Instructions
@onready var interact_line_item_audio_player = $InteractLineItemAudioPlayer
@onready var item_container = %ItemContainer
@onready var cursor_parent = %CursorParent
@onready var move_cursor_audio_player = $MoveCursorAudioPlayer

var shop_line_item_scene: PackedScene = preload(GameStrings.LINE_ITEM_MENU_ITEM_SCENE_PATH)
var current_line_item_in_focus: LineItemMenuItem

var buyer_inventory: Inventory

var type_controller


func _ready():
	setup_instructions()
	setup_items()
		
		
func _process(delta):
	if Input.is_action_just_pressed("interact"):
		try_interact_focused_item()
	
	
func set_type_controller(controller):
	type_controller = controller
	type_controller.seller_inventory.item_added.connect(on_item_added_to_inventory)
	type_controller.seller_inventory.item_removed.connect(on_item_removed_from_inventory)
	
	
func setup_instructions():
	if type_controller == null:
		return
	instructions.text = type_controller.get_instructions()
	
	
func setup_items():
	for child in item_container.get_children():
		child.free()
		
	if type_controller == null || type_controller.seller_inventory.is_empty():
		cursor_parent.visible = false
		return
		
	for item in type_controller.seller_inventory.storage["items"]:
		add_line_item(type_controller.seller_inventory\
		.storage["items"][item]["item_resource"])
	

func try_interact_focused_item():
	print("interacted with line item!")
	if current_line_item_in_focus == null:
		return false
	else:
		print(current_line_item_in_focus)
		
	var success = type_controller.interact(current_line_item_in_focus)
	if success:
		interact_line_item_audio_player.play()
	

func add_line_item(item: Item):
	var line_item_instance = shop_line_item_scene.instantiate() as LineItemMenuItem
	item_container.add_child(line_item_instance)
	line_item_instance.set_inventory_to_track(type_controller.seller_inventory)
	line_item_instance.set_item(item)
	line_item_instance.set_controller(type_controller)
	line_item_instance.selected.connect(on_line_item_selected)
	
	if item_container.get_child_count() == 1:
		cursor_parent.visible = true
		grab_focus_after_break(line_item_instance)
		
	return line_item_instance


func grab_focus_after_break(next_focus_item: LineItemMenuItem):
	await get_tree().create_timer(0.02).timeout
	if next_focus_item == null:
		return
	next_focus_item.grab_focus()
	
	
func remove_item_and_update_focus(line_item: LineItemMenuItem):
	var removed_item_index = item_container.get_children().find(line_item)
	print("removing sold item from shop")
	item_container.remove_child(line_item)
	
	var items_in_shop_now = item_container.get_child_count()
	if items_in_shop_now == 0:
		cursor_parent.visible = false
	elif current_line_item_in_focus != line_item:
		grab_focus_after_break(current_line_item_in_focus)
	else:
		var next_focus_item
		if removed_item_index == items_in_shop_now:
			# Last item, set focus to previous item
			next_focus_item = item_container.get_child(removed_item_index - 1) as LineItemMenuItem
		else:
			# Not last item, set focus to next item
			print("position of cursor for index 0 item: " \
			+ str(get_cursor_position_for_line_item(item_container.get_child(0))))
			next_focus_item = item_container.get_child(removed_item_index) as LineItemMenuItem
			
		grab_focus_after_break(next_focus_item)
		
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
