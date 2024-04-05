extends Node

@export var win_screen_scene: PackedScene
@export var level_timelimit_manager: LevelTimelimitManager


func _ready() -> void:
	GameEvents.game_won.connect(on_game_won)
	
	
func instantiate_win_screen():
	var win_screen_instance = win_screen_scene.instantiate() as WinScreen
	get_tree().get_first_node_in_group(GameStrings.UI_INSTANCE_LAYER).add_child(win_screen_instance)
	win_screen_instance.set_score(level_timelimit_manager.get_remaining_time())
	
	
func on_game_won():
	instantiate_win_screen()
