extends Area2D
class_name InteractComponent

signal area_enteredx
signal area_exitedx

const BASE_RADIUS = 5

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var collision_radius = BASE_RADIUS


func _ready():
#	print("setting collision radius to " + str(collision_radius))
#	collision_shape_2d.shape.set_radius(collision_radius)
	init_radius()
	area_entered.connect(on_player_entered_area)
	area_exited.connect(on_player_exited_area)
	
	
func init_radius():
	if collision_radius != BASE_RADIUS:
		var shape = CircleShape2D.new() as CircleShape2D
		shape.set_radius(collision_radius)
		print("setting shape")
		collision_shape_2d.shape = shape


func on_player_entered_area(other_area: Area2D):
	GameEvents.emit_interactable_opened()
	area_enteredx.emit()
	
	
func on_player_exited_area(other_area: Area2D):
	GameEvents.emit_interactable_closed()
	area_exitedx.emit()
