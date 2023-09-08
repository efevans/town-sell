extends CanvasLayer

@onready var margin_container = $MarginContainer
@onready var item_container = %ItemContainer
@onready var animation_player = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
#	for child in item_container.get_children():
#		child.queue_free()
	play_in()
	pass


func play_in():
	animation_player.play("in")
	
	
func close():
	animation_player.play_backwards("in")
	await animation_player.animation_finished
	queue_free()
