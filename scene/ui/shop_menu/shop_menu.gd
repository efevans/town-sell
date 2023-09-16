extends CanvasLayer
class_name ShopMenu

@onready var animation_player = $AnimationPlayer
@onready var inner_menu_container = %InnerMenuContainer

@export var test_items: Array[Item]

var test_scene: PackedScene = preload("res://scene/ui/line_item_menu/line_item_menu.tscn")
var npc_owner: NPC
#
#
func setup(npc: NPC):
	npc_owner = npc
	return self


func _ready():
	play_in()
	
	
func set_inner_menu(inner_menu: Container):
	inner_menu_container.add_child(inner_menu)
#	var test_inner_menu = test_scene.instantiate() as LineItemMenu
#	test_inner_menu.tracked_inventory = npc_owner.inventory
#	inner_menu_container.add_child(test_inner_menu)
		
		
#func _process(delta):
#	if Input.is_action_just_pressed("interact"):
#		try_buy_focused_item()
#
#
#func set_inventory_to_track(new_inventory: Inventory):
#	tracked_inventory = new_inventory
#
#
#func setup_inventory():
#	for child in item_container.get_children():
#		child.queue_free()
#
#	if tracked_inventory.is_empty():
#		cursor_parent.visible = false
#		return
#
#	var first_line_item: ShopLineItem = null
#	for item in tracked_inventory.storage["items"]:
#		var line_item_instance = shop_line_item_scene.instantiate() as ShopLineItem
#		item_container.add_child(line_item_instance)
#		line_item_instance.set_inventory_to_track(tracked_inventory)
#		line_item_instance.set_item(tracked_inventory.storage["items"][item]["item_resource"])
#		line_item_instance.selected.connect(on_line_item_selected)
#
#		if first_line_item == null:
#			first_line_item = line_item_instance
#
#	Callable(grab_focus_after_break.bind(first_line_item)).call_deferred()
##	Callable(first_line_item.grab_focus).call_deferred()
#
#
#func try_buy_focused_item():
#	if current_line_item_in_focus == null:
#		return false
#
#	var item = current_line_item_in_focus.item
#	if PlayerInventory.inventory.get_gold() < item.base_price:
#		return false
#
#	buy_item(item)
#	return true
#
#
#func buy_item(item: Item):
#	print("buying item " + str(current_line_item_in_focus))
#	$BuyItemAudioPlayer.play()
#	PlayerInventory.inventory.subtract_gold(item.base_price)
#	PlayerInventory.inventory.add_item(item)
#
#	tracked_inventory.remove_item(item)
#	if !tracked_inventory.has_item(item):
#		remove_item_from_menu_and_update_focus()
	
	
#func remove_item_from_menu_and_update_focus():
#	var current_line_item_index = item_container.get_children().find(current_line_item_in_focus)
#
#	var items_in_shop = item_container.get_child_count()
#	print("before buying, " + str(items_in_shop) + " items in shop")
#	if items_in_shop == 1:
#		cursor_parent.visible = false
#	else:
#		var next_focus_item
#		if current_line_item_index == items_in_shop - 1:
#			# Last item, set focus to previous item
#			next_focus_item = item_container.get_child(current_line_item_index - 1) as ShopLineItem
#		else:
#			# Not last item, set focus to next item
#			next_focus_item = item_container.get_child(current_line_item_index + 1) as ShopLineItem
#
#		Callable(grab_focus_after_break.bind(next_focus_item)).call_deferred()
##		Callable(next_focus_item.grab_focus).call_deferred()
#
#	print("removing bought item from shop")
#	current_line_item_in_focus.queue_free()
	

#func grab_focus_after_break(next_focus_item: ShopLineItem):
#	await get_tree().create_timer(0.01).timeout
#	next_focus_item.grab_focus()


func play_in():
	animation_player.play("in")
	
	
func close():
	animation_player.play_backwards("in")
	await animation_player.animation_finished
	queue_free()
	

#func get_cursor_position_for_line_item(line_item: ShopLineItem):
#	return line_item.global_position + cursor_offset
#
#
#func move_cursor_to_line_item(line_item: ShopLineItem):
#	print("selected line item at " + str(line_item.global_position))
#	var target_position = get_cursor_position_for_line_item(line_item)
#	var tween = create_tween()
#	tween.tween_property(cursor_parent, "global_position", target_position, 0.1)\
#	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
#
#
#func on_line_item_selected(line_item: ShopLineItem):
#	current_line_item_in_focus = line_item
#	move_cursor_audio_player.play()
#	move_cursor_to_line_item(line_item)
