extends CanvasLayer
class_name LevelTimelimitManager

@onready var level_timer = %LevelTimer

var end_screen_scene = preload(GameStrings.GAME_OVER_SCREEN_SCENE)


func _ready():
	level_timer.timeout.connect(on_level_timeout)
	

func get_remaining_time() -> int:
	return int(level_timer.time_left)
	
	
func on_level_timeout():
	GameEvents.emit_game_over()
	var end_screen_instance = end_screen_scene.instantiate()
	get_tree().get_first_node_in_group(GameStrings.UI_INSTANCE_LAYER).add_child(end_screen_instance)
