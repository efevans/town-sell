extends AnimationPlayer

signal cutscene_started
signal cutscene_ended

func _ready():
	print("Cutscene Manager ready")
	GameEvents.gate_opened.connect(on_gate_opened)
	

func play_player_opening_gate_cutscene(gate: Gate):
	print("Cutscene Manager responding to gate opening signal")
	GameEvents.emit_cutscene_started()
	get_tree().paused = true
	ScreenTransition.transition_with_custom_speed(0.2)
	await ScreenTransition.transitioned_halfway
	play("pass_through_gate")
	await ScreenTransition.transition_completed
	await animation_finished
#	ScreenTransition.transition_with_custom_speed(0.2)
#	await ScreenTransition.transitioned_halfway
#	get_tree().paused = false
#	get_tree().change_scene_to_file(GameStrings.TITLE_SCREEN)
	GameEvents.emit_game_won()

	
func on_gate_opened(gate: Gate):
	play_player_opening_gate_cutscene(gate)
