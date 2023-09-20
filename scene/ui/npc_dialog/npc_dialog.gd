extends CanvasLayer
class_name NPCDialog

@onready var animation_player = $AnimationPlayer
@onready var npc_text = %NPCText


func _ready():
	play_in()


func _process(delta):
	pass
	
	
func set_text(text: String):
	npc_text.clear()
	npc_text.append_text(text)


func play_in():
	animation_player.play("in")
	
	
func close():
	animation_player.play_backwards("in")
	await animation_player.animation_finished
	queue_free()
