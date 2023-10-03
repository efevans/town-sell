extends Node

static var toast_scene: PackedScene = preload(GameStrings.TOAST_SCENE_PATH)

@onready var audio_stream_player = %AudioStreamPlayer


func _ready():
	GameEvents.item_indirectly_obtained.connect(on_item_indirectly_obtained)
	GameEvents.gold_indirectly_obtained.connect(on_gold_indirectly_obtained)


func on_item_indirectly_obtained(item: Item):
	audio_stream_player.play()
	var toast_instance = toast_scene.instantiate()
	Common.get_ui_layer().add_child(toast_instance)
	toast_instance.set_subject(item)


func on_gold_indirectly_obtained(amount: int):
	audio_stream_player.play()
	var toast_instance = toast_scene.instantiate()
	Common.get_ui_layer().add_child(toast_instance)
	toast_instance.set_subject(amount)
