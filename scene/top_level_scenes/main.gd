extends Node


func _process(delta):
	if Input.is_action_just_pressed("debug_load_level"):
		await ScreenTransition.transition_to_scene(GameStrings.LEVEL_SCENE)
