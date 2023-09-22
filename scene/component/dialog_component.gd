extends Node
class_name DialogComponent

const BASE_DIALOG_SCENE: PackedScene = preload(GameStrings.NPC_DIALOG_SCENE_PATH)

@export_group("Node Dependencies")
@export var dialog_text: Dialog
@export var interaction_signaler: InteractComponent

@export_group("", "")

var current_dialog_instance: NPCDialog


func _ready():
#	get_interact_from_parent()
	interaction_signaler.area_enteredx.connect(on_interaction_started)
	interaction_signaler.area_exitedx.connect(on_interaction_ended)
	
	
#func get_interact_from_parent():
#	# If an InteractComponent is not set in node, look for one in parent
#	if interaction_signaler != null:
#		return
#
#	var parent_interact_component = get_parent().interact_component
#	if parent_interact_component == null:
#		push_error("Interact Component not set in node and could not find in parent")
#
#	interaction_signaler = parent_interact_component


func setup():
	current_dialog_instance = BASE_DIALOG_SCENE.instantiate() as NPCDialog
	get_tree().root.add_child(current_dialog_instance)
	if dialog_text != null:
		current_dialog_instance.set_text(dialog_text.text)


func on_interaction_started():
	setup()
	

func on_interaction_ended():
	current_dialog_instance.close()
