extends CanvasLayer
class_name WinScreen

@onready var retry_button := %RetryButton
@onready var quit_button := %QuitButton
@onready var audio_stream_player := %AudioStreamPlayer
@onready var score_label: Label = %ScoreLabel

var normal_stylebox_theme: StyleBox
var focused_button: Button

var first_focus: bool = true


func _ready():
	get_tree().paused = true
	normal_stylebox_theme = retry_button.get_theme_stylebox("normal")
	retry_button.pressed.connect(on_retry_pressed)
	quit_button.pressed.connect(on_quit_pressed)
	
	for button in [retry_button, quit_button]:
		ready_button_stylebox_changes(button)
		
	retry_button.grab_focus()
	
	
func _process(delta):
	if Input.is_action_just_pressed("interact"):
		handle_button_pressed()
		
		
func set_score(value):
	score_label.text = str(value)
	
	
func ready_button_stylebox_changes(button: Button):
	button.focus_entered.connect(on_focus_entered.bind(button))
	button.focus_exited.connect(on_focus_exited.bind(button))
	
	
func set_pressed_style(button: Button):
	focused_button = button
	button.add_theme_stylebox_override("normal", retry_button.get_theme_stylebox("hover"))
	
	
func set_unpressed_style(button: Button):
	button.add_theme_stylebox_override("normal", normal_stylebox_theme)
	
	
func handle_button_pressed():
	focused_button.pressed.emit()
	
	
func on_focus_entered(button: Button):
	if first_focus:
		first_focus = false
	else:
		audio_stream_player.play()
	set_pressed_style(button)
	
	
func on_focus_exited(button: Button):
	set_unpressed_style(button)


func on_retry_pressed():
	ScreenTransition.transition_to_scene(GameStrings.LEVEL_SCENE)
	await ScreenTransition.transitioned_halfway
	get_tree().paused = false
	print("retry pressed")
	
	
func on_quit_pressed():
	ScreenTransition.transition_to_scene(GameStrings.TITLE_SCREEN)
	await ScreenTransition.transitioned_halfway
	get_tree().paused = false
	print("quit pressed")
