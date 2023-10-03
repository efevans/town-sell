extends Node


func get_ui_layer() -> Node:
	return get_tree().get_first_node_in_group(GameStrings.UI_INSTANCE_LAYER)
