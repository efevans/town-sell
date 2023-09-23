extends Node2D
class_name Gate

@onready var gate_door_left = $GateDoor
@onready var gate_door_right = $Reverse/GateDoor2
		
		
func open():
	gate_door_left.open_door()
	gate_door_right.open_door()
