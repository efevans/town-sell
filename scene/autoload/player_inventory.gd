extends Node

var inventory: Inventory = Inventory.new()


func _process(delta):
	if Input.is_action_just_pressed("debut_print_inventory"):
		print(inventory.storage)
