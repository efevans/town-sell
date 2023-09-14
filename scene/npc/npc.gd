extends Node2D

@onready var npc_interact_area_2d: NPCInteractArea2D = $NPCInteractArea2D
@onready var gpu_particles_2d = $GPUParticles2D
@onready var random_audio_stream_player_2d = $RandomAudioStreamPlayer2D

@export var npc_interaction_scene: PackedScene

var current_interact_instance


# Called when the node enters the scene tree for the first time.
func _ready():
	npc_interact_area_2d.area_entered.connect(on_player_entered_area)
	npc_interact_area_2d.area_exited.connect(on_player_exited_area)
	npc_interact_area_2d.npc_interaction_scene = npc_interaction_scene


func on_player_entered_area(other_area: Area2D):
	gpu_particles_2d.emitting = true
	random_audio_stream_player_2d.play_random()
	current_interact_instance = npc_interaction_scene.instantiate()
	get_tree().root.add_child(current_interact_instance)
	GameEvents.emit_npc_menu_opened()
	print("NPC: A player entered my area")


func on_player_exited_area(other_area: Area2D):
	current_interact_instance.close()
	GameEvents.emit_npc_menu_closed()
	print("NPC: A player exited my area");
