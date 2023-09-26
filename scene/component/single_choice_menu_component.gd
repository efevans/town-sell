extends Node
class_name SingleChoiceMenuComponent

signal selected

static var npc_menu_scene: PackedScene = preload(GameStrings.NPC_MENU_SCENE_PATH)
static var single_choice_menu_scene: PackedScene = preload(GameStrings.SINGLE_CHOICE_MENU_SCENE_PATH)

@export_group("Node Dependencies")
@export var interaction_signaler: InteractComponent

@export_group("", "")

var current_menu_instance: NPCMenu
var current_choice_menu_instance: SingleChoiceMenu
var title_text: String
var button_text: String


func _ready():
	interaction_signaler.area_enteredx.connect(on_interaction_started)
	interaction_signaler.area_exitedx.connect(on_interaction_ended)
	
	
func set_title_and_label(new_title: String, new_label: String):
	title_text = new_title
	button_text = new_label
	
	update_text()
	
	
func open_menu():
	current_choice_menu_instance = single_choice_menu_scene.instantiate() as SingleChoiceMenu
	update_text()
	current_choice_menu_instance.selected.connect(on_menu_choice_selected)
	
	current_menu_instance = npc_menu_scene.instantiate() as NPCMenu
	get_tree().get_first_node_in_group("ui_menu_layer").add_child(current_menu_instance)
	current_menu_instance.set_inner_menu(current_choice_menu_instance)
	
	
func update_text():
	if current_choice_menu_instance != null:
		current_choice_menu_instance.set_text(title_text, button_text)


func on_interaction_started():
	open_menu()
	

func on_interaction_ended():
	if current_menu_instance == null:
		return
	current_menu_instance.close()
	
	
func on_menu_choice_selected():
	selected.emit()
