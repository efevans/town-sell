extends Node
class_name DialogComponent

const BASE_DIALOG_SCENE: PackedScene = preload(GameStrings.NPC_DIALOG_SCENE_PATH)

@export var dialog_text: Dialog
@export var interaction_signaler: InteractComponent

var current_dialog_instance: NPCDialog


func _ready():
	interaction_signaler.area_enteredx.connect(on_interaction_started)
	interaction_signaler.area_exitedx.connect(on_interaction_ended)


func setup():
	current_dialog_instance = BASE_DIALOG_SCENE.instantiate() as NPCDialog
	get_tree().root.add_child(current_dialog_instance)
	if dialog_text != null:
		current_dialog_instance.set_text(dialog_text.text)


func on_interaction_started():
	setup()
	

func on_interaction_ended():
	current_dialog_instance.close()
