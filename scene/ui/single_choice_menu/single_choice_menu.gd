extends MarginContainer
class_name SingleChoiceMenu

signal selected

const CURSOR_OFFSET = Vector2(-22, 6)

@onready var cursor_parent = %CursorParent
@onready var interact_line_item_audio_player = %InteractLineItemAudioPlayer
@onready var choice = %Choice
@onready var main_label = %MainLabel
@onready var choice_label = %ChoiceLabel

var main_text: String = "Set Me"
var choice_text: String = "Set Me"


func _ready():
	set_cursor_position_after_break()
	update_labels()
		
		
func _process(delta):
	if Input.is_action_just_pressed("interact"):
		try_interact()


func set_text(new_main_text: String, new_choice_text: String):
	main_text = new_main_text
	choice_text = new_choice_text
	if is_node_ready():
		update_labels()
		
		
func update_labels():
	main_label.text = main_text
	choice_label.text = choice_text
		
		
func set_type_controller(controller):
	pass
	
	
func set_cursor_position_after_break():
	await get_tree().create_timer(0.02).timeout
	cursor_parent.global_position = choice.global_position + CURSOR_OFFSET


func try_interact():
	interact_line_item_audio_player.play()
	selected.emit()
