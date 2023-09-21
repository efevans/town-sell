extends Node2D

@onready var gate_door_left = $GateDoor
@onready var gate_door_right = $Reverse/GateDoor2
@onready var single_choice_menu_component: SingleChoiceMenuComponent = $SingleChoiceMenuComponent

static var SINGLE_CHOICE_MENU_SCENE = preload(GameStrings.SINGLE_CHOICE_MENU_SCENE_PATH)
static var BASE_MENU_SCENE: PackedScene = preload(GameStrings.NPC_MENU_SCENE_PATH)
static var BASE_DIALOG_SCENE: PackedScene = preload(GameStrings.NPC_DIALOG_SCENE_PATH)

var current_menu_instance: NPCMenu
var current_dialog_instnace: NPCDialog


func _ready():
	single_choice_menu_component.selected.connect(on_single_choice_selected)
	pass
		
		
func open():
	gate_door_left.open_door()
	gate_door_right.open_door()


func on_single_choice_selected():
	print("He bought?")
	open()
