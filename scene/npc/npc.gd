extends Node2D
class_name NPC

@onready var npc_interact_area_2d: NPCInteractArea2D = $NPCInteractArea2D
@onready var gpu_particles_2d = $GPUParticles2D
@onready var random_audio_stream_player_2d = $RandomAudioStreamPlayer2D

@export var npc_interaction_scene: PackedScene

@export var item_pool: Array[Item]

var current_interact_instance
var inventory: Inventory = Inventory.new()
var item_count: int = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	init_inventory()
	npc_interact_area_2d.area_entered.connect(on_player_entered_area)
	npc_interact_area_2d.area_exited.connect(on_player_exited_area)
	npc_interact_area_2d.npc_interaction_scene = npc_interaction_scene
	
	
func init_inventory():
	if item_pool == null || item_pool.is_empty():
		return
		
	for item_index in item_count:
		var item = item_pool.pick_random()
		inventory.add_item(item)


func on_player_entered_area(other_area: Area2D):
	gpu_particles_2d.emitting = true
	random_audio_stream_player_2d.play_random()
#	current_interact_instance = npc_interaction_scene.instantiate()
	current_interact_instance = ShopMenu.create(self)
	get_tree().root.add_child(current_interact_instance)
	GameEvents.emit_npc_menu_opened()
	print("NPC: A player entered my area")


func on_player_exited_area(other_area: Area2D):
	current_interact_instance.close()
	GameEvents.emit_npc_menu_closed()
	print("NPC: A player exited my area");
