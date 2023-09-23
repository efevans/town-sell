extends Node2D
class_name NPC

#@onready var interact_component: InteractComponent = $InteractComponent
@onready var gpu_particles_2d = $GPUParticles2D
@onready var random_audio_stream_player_2d = $RandomAudioStreamPlayer2D

var interact_component: InteractComponent
var inventory_component: InventoryComponent
var item_pricer_component: ItemPricerComponent


func _ready():
	set_optional_components()
	setup_interaction()
	
	
func get_inventory():
	if interact_component == null:
		return null
	return inventory_component.inventory
	

func get_item_pricer():
	if item_pricer_component == null:
		return null
	return item_pricer_component.item_pricer
	
	
func set_optional_components():
	interact_component = get_node_or_null("InteractComponent")
	inventory_component = get_node_or_null("InventoryComponent")
	item_pricer_component = get_node_or_null("ItemPricerComponent")


func setup_interaction():
	if interact_component == null:
		return
	interact_component.area_enteredx.connect(on_interact_opened)
	interact_component.area_exitedx.connect(on_interact_closed)
	
	
func on_interact_opened():
	gpu_particles_2d.emitting = true
	random_audio_stream_player_2d.play_random()
	print("NPC: A player interacted with me!")
	
	
func on_interact_closed():
	print("NPC: A player stopped interacting with me!");
