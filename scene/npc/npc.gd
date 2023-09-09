extends Node2D

@onready var npc_interact_area_2d: NPCInteractArea2D = $NPCInteractArea2D
@onready var gpu_particles_2d = $GPUParticles2D
@onready var random_audio_stream_player_2d = $RandomAudioStreamPlayer2D

@export var npc_interaction_scene: PackedScene

var player_in_range = false


# Called when the node enters the scene tree for the first time.
func _ready():
	npc_interact_area_2d.area_entered.connect(on_player_entered_area)
	npc_interact_area_2d.area_exited.connect(on_player_exited_area)
	npc_interact_area_2d.npc_interaction_scene = npc_interaction_scene
	
	
func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		if player_in_range:
			print("npc interacted with!")


func on_player_entered_area(other_area: Area2D):
	player_in_range = true
	gpu_particles_2d.emitting = true
	random_audio_stream_player_2d.play_random()
	print("NPC: A player entered my area")


func on_player_exited_area(other_area: Area2D):
	player_in_range = false
	print("NPC: A player exited my area");
