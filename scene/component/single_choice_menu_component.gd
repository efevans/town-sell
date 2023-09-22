extends Node
class_name SingleChoiceMenuComponent

signal selected

static var npc_menu_scene: PackedScene = preload(GameStrings.NPC_MENU_SCENE_PATH)
static var single_choice_menu_scene: PackedScene = preload(GameStrings.SINGLE_CHOICE_MENU_SCENE_PATH)

@export_group("Node Dependencies")
@export var interaction_signaler: InteractComponent

@export_group("", "")

var current_menu_instance: NPCMenu


func _ready():
	interaction_signaler.area_enteredx.connect(on_interaction_started)
	interaction_signaler.area_exitedx.connect(on_interaction_ended)
	
	
func open_menu():
	var single_choice_menu_instance = single_choice_menu_scene.instantiate() as SingleChoiceMenu
	single_choice_menu_instance.set_text("Hi", "Hello")
	single_choice_menu_instance.selected.connect(on_menu_choice_selected)
	
	current_menu_instance = npc_menu_scene.instantiate() as NPCMenu
	get_tree().root.add_child(current_menu_instance)
	current_menu_instance.set_inner_menu(single_choice_menu_instance)


func on_interaction_started():
	open_menu()
	

func on_interaction_ended():
	current_menu_instance.close()
	
	
func on_menu_choice_selected():
	selected.emit()
