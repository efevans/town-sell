extends Node2D

@onready var gate_door_left = $GateDoor
@onready var gate_door_right = $Reverse/GateDoor2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("space"):
		print("space pressed!")
		gate_door_left.open_door()
		gate_door_right.open_door()
