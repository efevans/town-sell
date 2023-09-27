extends CanvasLayer

@onready var retry_button := %RetryButton
@onready var quit_button := %QuitButton

var normal_stylebox_theme: StyleBox
var focused_button: Button


func _ready():
	normal_stylebox_theme = retry_button.get_theme_stylebox("normal")
	retry_button.pressed.connect(on_retry_pressed)
	quit_button.pressed.connect(on_quit_pressed)
	
	for button in [retry_button, quit_button]:
		ready_button_stylebox_changes(button)
		
	retry_button.grab_focus()
	
	
func _process(delta):
	if Input.is_action_just_pressed("interact"):
		handle_button_pressed()
	
	
func ready_button_stylebox_changes(button: Button):
	button.focus_entered.connect(set_pressed_style.bind(button))
	button.focus_exited.connect(set_unpressed_style.bind(button))
	
	
func set_pressed_style(button: Button):
	focused_button = button
	button.add_theme_stylebox_override("normal", retry_button.get_theme_stylebox("hover"))
	
	
func set_unpressed_style(button: Button):
	button.add_theme_stylebox_override("normal", normal_stylebox_theme)
	
	
func handle_button_pressed():
	focused_button.pressed.emit()


func on_retry_pressed():
	print("retry pressed")
	
	
func on_quit_pressed():
	print("quit pressed")
