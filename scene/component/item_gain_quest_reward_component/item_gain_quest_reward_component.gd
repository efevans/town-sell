extends Node

@export_group("Quest Reward Properties")
@export var item_reward: Item
@export var quest_node: Node

@export_group("", "")


func _ready():
	quest_node.quest_completed.connect(on_quest_completed)
	
	
func on_quest_completed():
	PlayerInventory.inventory.add_item(item_reward)
	print("quest complete! Adding item to player: " + item_reward.name)
