extends Node

var inventory := Inventory.new()


func _ready():
	inventory.max_storage_size = 8


func _process(delta):
	if Input.is_action_just_pressed("debut_print_inventory"):
		print(inventory.storage)
	if Input.is_action_just_pressed("debug_add_gold"):
		inventory.add_gold(1000)
