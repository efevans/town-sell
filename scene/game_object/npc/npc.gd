extends Node2D
class_name NPC

@onready var interact_component = $InteractComponent
@onready var gpu_particles_2d = $GPUParticles2D
@onready var random_audio_stream_player_2d = $RandomAudioStreamPlayer2D

@export_group("Inventory Properties", "item_")
@export var item_pool: Array[Item]
@export var item_count: int = 5

@export_group("", "")

var inventory: Inventory = Inventory.new()


func _ready():
	init_inventory()
	print(interact_component)
	setup_interaction()
	
func _process(delta):
	if Input.is_action_just_pressed("debut_print_inventory"):
		var item = inventory.get_random_item()
		if item == null:
			return
		inventory.remove_item(item)


func setup_interaction():
	if interact_component == null:
		return
	interact_component.opened.connect(on_interact_opened)
	interact_component.closed.connect(on_interact_closed)
	
	
func init_inventory():
	if item_pool == null || item_pool.is_empty():
		return
		
	for item_index in item_count:
		var item = item_pool.pick_random()
		inventory.add_item(item)
	
	
func on_interact_opened():
	gpu_particles_2d.emitting = true
	random_audio_stream_player_2d.play_random()
	print("NPC: A player interacted with me!")
	pass
	
	
func on_interact_closed():
	print("NPC: A player stopped interacting with me!");
	pass
