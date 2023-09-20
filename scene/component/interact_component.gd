extends Area2D
class_name InteractComponent

signal opened
signal closed

const BASE_MENU_SCENE: PackedScene = preload(GameStrings.NPC_MENU_SCENE_PATH)
const BASE_DIALOG_SCENE: PackedScene = preload(GameStrings.NPC_DIALOG_SCENE_PATH)

#@onready var interact_area_2d: CollisionShape2D = $CollisionShape2D

@export_group("Menu Properties")
@export var menu_type_scene: PackedScene
@export var menu_type: LineItemMenu.Type = LineItemMenu.Type.PLAYER_BUY

@export_group("", "")

var current_menu_instance: NPCMenu
var current_dialog_instance: NPCDialog

var owner_entity


func _ready():
	owner_entity = get_parent()
	area_entered.connect(on_player_entered_area)
	area_exited.connect(on_player_exited_area)
	
	
#func init(owner):
#	owner_entity = owner
		
		
func setup_menu():
	current_menu_instance = BASE_MENU_SCENE.instantiate() as NPCMenu
	get_tree().root.add_child(current_menu_instance)
	
	var inner_shop_instance = menu_type_scene.instantiate() as LineItemMenu
	# instantiate
	var line_item_menu_type_controller = LineItemMenuInteractionControllerFactory.new()\
	.create(menu_type, owner_entity)
	inner_shop_instance.set_type_controller(line_item_menu_type_controller)
	
	current_menu_instance.set_inner_menu(inner_shop_instance)
	
	
func setup_dialog():
	current_dialog_instance = BASE_DIALOG_SCENE.instantiate() as NPCDialog
	get_tree().root.add_child(current_dialog_instance)


func on_player_entered_area(other_area: Area2D):
	setup_menu()
	setup_dialog()
	
	opened.emit()
	GameEvents.emit_interactable_opened()
	
	
func on_player_exited_area(other_area: Area2D):
	current_menu_instance.close()
	current_dialog_instance.close()
	
	closed.emit()
	GameEvents.emit_interactable_closed()
