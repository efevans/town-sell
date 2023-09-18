extends CanvasLayer
class_name NPCDialog

@onready var animation_player = $AnimationPlayer


func _ready():
	play_in()


func _process(delta):
	pass


func play_in():
	animation_player.play("in")
	
	
func close():
	animation_player.play_backwards("in")
	await animation_player.animation_finished
	queue_free()
