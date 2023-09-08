extends StaticBody2D

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer

var door_1 = preload("res://scene/door.png")
var door_2 = preload("res://scene/door2.png")
var door_3 = preload("res://scene/door3.png")
var door_4 = preload("res://scene/door_open.png")


func open_door():
	animation_player.play("open", -1, 0.15)


func set_door_position(door_position: int):
	print("Setting door to position " + str(door_position))
	match door_position:
		1:
			sprite_2d.texture = door_1
		2:
			sprite_2d.texture = door_2
		3:
			sprite_2d.texture = door_3
		4:
			sprite_2d.texture = door_4
		_: 
			sprite_2d.texture = door_1
