extends Node

signal cutscene_started
signal cutscene_ended

var player: Player

func _ready():
	print("Cutscene Manager ready")
	GameEvents.gate_opened.connect(on_gate_opened)
	
	
func close_ui_menus():
	var menus = get_tree().get_first_node_in_group("ui_menu_layer").get_children()
	for menu in menus:
		menu.close()
	

func play_player_opening_gate_cutscene(gate: Gate):
	player = get_tree().get_first_node_in_group("player")
	print("Cutscene Manager responding to gate opening signal")
	GameEvents.emit_cutscene_started()
	get_tree().paused = true
	close_ui_menus()
	ScreenTransition.transition_with_custom_speed(0.2)
	await ScreenTransition.transitioned_halfway
	move_player_in_front_of_gate(player, gate)
	await ScreenTransition.transition_completed
	
	
func move_player_in_front_of_gate(player: Player, gate: Gate):
	player.global_position = gate.global_position + Vector2(0, 40)

	
func on_gate_opened(gate: Gate):
	play_player_opening_gate_cutscene(gate)
