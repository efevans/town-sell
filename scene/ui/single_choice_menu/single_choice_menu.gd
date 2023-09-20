extends MarginContainer
class_name SingleChoiceMenu

const CURSOR_OFFSET = Vector2(-22, 6)

@onready var cursor_parent = %CursorParent
@onready var interact_line_item_audio_player = %InteractLineItemAudioPlayer
@onready var choice = %Choice


func _ready():
	print("before")
	set_cursor_position_after_break()
	print("after")
	pass
		
		
func _process(delta):
	if Input.is_action_just_pressed("interact"):
		try_interact()
		
		
func set_type_controller(controller):
	pass
	
	
func set_cursor_position_after_break():
	await get_tree().create_timer(0.02).timeout
	cursor_parent.global_position = choice.global_position + CURSOR_OFFSET


func try_interact():
#	var success = type_controller.interact(current_line_item_in_focus.item)
#	if success:
#		interact_line_item_audio_player.play()
	interact_line_item_audio_player.play()
	pass
