extends Node2D
class_name NPC

@onready var interact_component: InteractComponent = $InteractComponent
@onready var gpu_particles_2d = $GPUParticles2D
@onready var random_audio_stream_player_2d = $RandomAudioStreamPlayer2D


func _ready():
	print(interact_component)
	setup_interaction()


func setup_interaction():
	if interact_component == null:
		return
	interact_component.area_enteredx.connect(on_interact_opened)
	interact_component.area_exitedx.connect(on_interact_closed)
	
	
func on_interact_opened():
	gpu_particles_2d.emitting = true
	random_audio_stream_player_2d.play_random()
	print("NPC: A player interacted with me!")
	pass
	
	
func on_interact_closed():
	print("NPC: A player stopped interacting with me!");
	pass
