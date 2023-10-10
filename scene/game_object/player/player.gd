extends CharacterBody2D
class_name Player

const MAX_SPEED = 120
const ACCELERATION_SMOOTHING = 25

var player_has_control: bool = true


func _ready():
	GameEvents.cutscene_started.connect(on_cutscene_started)
	GameEvents.cutscene_ended.connect(on_cutscene_ended)


func _process(delta):
	if player_has_control:
		move(delta)
	

func move(delta):
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	
	var target_velocity = direction * MAX_SPEED
	velocity = velocity.lerp(target_velocity, 1.0 - exp(-delta * ACCELERATION_SMOOTHING))
	move_and_slide()


func get_movement_vector():
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	return Vector2(x_movement, y_movement)
	
	
func on_cutscene_started():
	player_has_control = false
	
	
func on_cutscene_ended():
	player_has_control = true
