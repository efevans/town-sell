extends Node
class_name LineItemMenuComponent

signal selected

static var npc_menu_scene: PackedScene = preload(GameStrings.NPC_MENU_SCENE_PATH)
static var line_item_menu_scene: PackedScene = preload(GameStrings.LINE_ITEM_MENU_SCENE_PATH)

@export_group("Menu Properties", "_menu")
@export var menu_sub_type: LineItemMenu.Type = LineItemMenu.Type.PLAYER_BUY

@export_group("Node Dependencies")
@export var interaction_signaler: InteractComponent
@export var owner_npc: NPC

@export_group("", "")

var current_menu_instance: NPCMenu


func _ready():
	interaction_signaler.area_enteredx.connect(on_interaction_started)
	interaction_signaler.area_exitedx.connect(on_interaction_ended)
	
	
func open_menu():
	
	var line_item_menu_type_controller = LineItemMenuInteractionControllerFactory.new()\
	.create(menu_sub_type, owner_npc)
	
	var line_item_menu_instance = line_item_menu_scene.instantiate() as LineItemMenu
	line_item_menu_instance.set_type_controller(line_item_menu_type_controller)
	
	current_menu_instance = npc_menu_scene.instantiate() as NPCMenu
	
	get_tree().get_first_node_in_group(GameStrings.UI_INSTANCE_LAYER).add_child(current_menu_instance)
	current_menu_instance.set_inner_menu(line_item_menu_instance)


func on_interaction_started():
	open_menu()
	

func on_interaction_ended():
	current_menu_instance.close()
