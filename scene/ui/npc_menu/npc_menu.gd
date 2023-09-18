extends CanvasLayer
class_name NPCMenu

@onready var animation_player = $AnimationPlayer
@onready var inner_menu_container = %InnerMenuContainer
@onready var menu_margin_container = %MenuMarginContainer

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
	
	
#func animate_menu_in():
#	# Running these in an animation player was running into 
#	# an issue of Godot resizing the container after stopping execution
#	var tween = create_tween()
#	tween.tween_property(menu_margin_container, "position:x", 640, 0.0)
#	tween.tween_property(menu_margin_container, "position:x", 0, 0.50)\
#	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
#
#
#func animate_menu_out():
#	var tween = create_tween()
#	tween.tween_property(menu_margin_container, "position:x", 640, 0.50)\
#	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
#	tween.tween_callback(queue_free)


func play_in():
#	animate_menu_in()
	animation_player.play("in")
#	pass
	
	
func close():
#	animate_menu_out()
	animation_player.play_backwards("in")
	await animation_player.animation_finished
	queue_free()
