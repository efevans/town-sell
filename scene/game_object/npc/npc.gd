extends Node2D
class_name NPC

#const BASE_MENU_SCENE: PackedScene = preload(GameStrings.NPC_MENU_SCENE_PATH)
#const BASE_DIALOG_SCENE: PackedScene = preload(GameStrings.NPC_DIALOG_SCENE_PATH)

#@onready var npc_interact_area_2d: NPCInteractArea2D = $NPCInteractArea2D
@onready var interact_component = $InteractComponent
@onready var gpu_particles_2d = $GPUParticles2D
@onready var random_audio_stream_player_2d = $RandomAudioStreamPlayer2D

#@export_group("Menu Properties")
#@export var menu_type_scene: PackedScene
#@export var menu_type: LineItemMenu.Type = LineItemMenu.Type.PLAYER_BUY

@export_group("Inventory Properties", "item_")
@export var item_pool: Array[Item]
@export var item_count: int = 5

@export_group("", "")

#var current_interact_instance: NPCMenu
#var current_dialog_instance: NPCDialog
var inventory: Inventory = Inventory.new()


func _ready():
	init_inventory()
#	npc_interact_area_2d.area_entered.connect(on_player_entered_area)
#	npc_interact_area_2d.area_exited.connect(on_player_exited_area)
	print(interact_component)
	interact_component.opened.connect(on_interact_opened)
	interact_component.closed.connect(on_interact_closed)
	
	
func _process(delta):
	if Input.is_action_just_pressed("debut_print_inventory"):
		var item = inventory.get_random_item()
		if item == null:
			return
		inventory.remove_item(item)

	
	
func init_inventory():
	if item_pool == null || item_pool.is_empty():
		return
		
	for item_index in item_count:
		var item = item_pool.pick_random()
		inventory.add_item(item)
		
		
#func setup_menu():
#	current_interact_instance = BASE_MENU_SCENE.instantiate().setup(self) as NPCMenu
#	get_tree().root.add_child(current_interact_instance)
#
#	var inner_shop_instance = menu_type_scene.instantiate() as LineItemMenu
#	# instantiate
#	var line_item_menu_type_controller = LineItemMenuInteractionControllerFactory.new()\
#	.create(menu_type, self)
#	inner_shop_instance.set_type_controller(line_item_menu_type_controller)
#
#	current_interact_instance.set_inner_menu(inner_shop_instance)
#
#
#func setup_dialog():
#	current_dialog_instance = BASE_DIALOG_SCENE.instantiate() as NPCDialog
#	get_tree().root.add_child(current_dialog_instance)


#func on_player_entered_area(other_area: Area2D):
#	setup_menu()
#	setup_dialog()
#
#	GameEvents.emit_interactable_opened()
#	gpu_particles_2d.emitting = true
#	random_audio_stream_player_2d.play_random()
#	print("NPC: A player entered my area")
#
#
#func on_player_exited_area(other_area: Area2D):
#	current_interact_instance.close()
#	current_dialog_instance.close()
#	GameEvents.emit_interactable_closed()
#	print("NPC: A player exited my area");
	
	
func on_interact_opened():
	gpu_particles_2d.emitting = true
	random_audio_stream_player_2d.play_random()
	print("NPC: A player interacted with me!")
	pass
	
	
func on_interact_closed():
	print("NPC: A player stopped interacting with me!");
	pass
