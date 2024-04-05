extends Node

const ROAM_SPEED = 18

@onready var start_button: Button = %StartButton
@onready var options_button: Button = %OptionsButton
@onready var audio_stream_player := %AudioStreamPlayer

@export var roam_path_2ds: Array[Path2D]
@export var npc_scene: PackedScene

var normal_stylebox_theme: StyleBox
var focused_button: Button

var first_focus: bool = true


func _ready() -> void:
	normal_stylebox_theme = start_button.get_theme_stylebox("normal")
	start_button.pressed.connect(on_start_pressed)
	options_button.pressed.connect(on_options_pressed)
	
	for button in [start_button, options_button]:
		ready_button_stylebox_changes(button)
		
	start_button.grab_focus()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		handle_button_pressed()
		
	for roam_path in roam_path_2ds:
		for child in roam_path.get_children():
			var path_follow = child as PathFollow2D
			path_follow.progress += delta * ROAM_SPEED
	
	
func handle_button_pressed():
	focused_button.pressed.emit()
	
	
func ready_button_stylebox_changes(button: Button):
	button.focus_entered.connect(on_focus_entered.bind(button))
	button.focus_exited.connect(on_focus_exited.bind(button))
	
	
func on_focus_entered(button: Button):
	if first_focus:
		first_focus = false
	else:
		audio_stream_player.play()
	set_pressed_style(button)
	
	
func on_focus_exited(button: Button):
	set_unpressed_style(button)
	
	
func set_pressed_style(button: Button):
	focused_button = button
	button.add_theme_stylebox_override("normal", start_button.get_theme_stylebox("hover"))
	
	
func set_unpressed_style(button: Button):
	button.add_theme_stylebox_override("normal", normal_stylebox_theme)


func on_start_pressed():
	ScreenTransition.transition_to_scene(GameStrings.LEVEL_SCENE)
	await ScreenTransition.transitioned_halfway


func on_options_pressed():
	pass
