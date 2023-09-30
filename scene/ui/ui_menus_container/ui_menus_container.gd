extends Node


func _ready():
	GameEvents.game_over.connect(on_game_over)
	GameEvents.cutscene_started.connect(on_cutscene_started)


func hide_menus():
	for child in get_children():
		child.queue_free()


func on_game_over():
	hide_menus()


func on_cutscene_started():
	hide_menus()
