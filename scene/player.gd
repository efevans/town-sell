extends CharacterBody2D

const MAX_SPEED = 150
const ACCELERATION_SMOOTHING = 25

#var current_npc_interact_instance

func _ready():
	$NPCInteractionArea2D.area_entered.connect(on_npc_entered_area)
	$NPCInteractionArea2D.area_exited.connect(on_npc_exited_area)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	
	var target_velocity = direction * MAX_SPEED
	velocity = velocity.lerp(target_velocity, 1.0 - exp(-delta * ACCELERATION_SMOOTHING))
	move_and_slide()


func get_movement_vector():
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	return Vector2(x_movement, y_movement)


func on_npc_entered_area(other_area: Area2D):
#	if other_area is NPCInteractArea2D:
#		var npc_interact_scene = other_area.npc_interaction_scene as PackedScene
#		current_npc_interact_instance = npc_interact_scene.instantiate()
#		get_tree().root.add_child(current_npc_interact_instance)
#		GameEvents.emit_npc_menu_opened()
	pass
		
		
func on_npc_exited_area(other_area: Area2D):
#	current_npc_interact_instance.close()
#	GameEvents.emit_npc_menu_closed()
	pass
