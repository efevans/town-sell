extends CanvasLayer

const TRANSITION_PAUSE_TIME: float = 0.1

signal transitioned_halfway
signal transition_completed

@onready var animation_player: AnimationPlayer = %AnimationPlayer

var skip_emit = false
	
	
func transition_to_scene(path_to_scene: String):
	transition()
	await transitioned_halfway
	get_tree().change_scene_to_file(path_to_scene)
	
	
func transition():
	transition_with_custom_speed(1.0)
	
	
func transition_with_custom_speed(custom_speed: float):
	animation_player.play("transition", -1.0, custom_speed)
	await transitioned_halfway
	await get_tree().create_timer(TRANSITION_PAUSE_TIME).timeout
	skip_emit = true
	animation_player.play("transition", -1.0, -custom_speed, true)
	await animation_player.animation_finished
	transition_completed.emit()
	
	
func emit_transitioned_halfway():
	if skip_emit:
		skip_emit = false
		return
	transitioned_halfway.emit()
