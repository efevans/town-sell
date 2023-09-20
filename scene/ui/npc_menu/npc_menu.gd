extends CanvasLayer
class_name NPCMenu

@onready var animation_player = $AnimationPlayer
@onready var inner_menu_container = %InnerMenuContainer
@onready var menu_margin_container = %MenuMarginContainer

var test_scene: PackedScene = preload("res://scene/ui/line_item_menu/line_item_menu.tscn")


func _ready():
	play_in()
	
	
func set_inner_menu(inner_menu: Container):
	for child in inner_menu_container.get_children():
		child.queue_free()
	inner_menu_container.add_child(inner_menu)


func play_in():
	animation_player.play("in")
	
	
func close():
	animation_player.play_backwards("in")
	await animation_player.animation_finished
	queue_free()
