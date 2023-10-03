extends Node

@export_group("Quest Reward Properties")
@export var gold_reward: int
@export var quest_node: Node

@export_group("", "")


func _ready():
	quest_node.quest_completed.connect(on_quest_completed)
	
	
func on_quest_completed():
	PlayerInventory.inventory.add_gold(gold_reward)
	GameEvents.emit_gold_indirectly_obtained(gold_reward)
	print("quest complete! Adding gold to player: " + str(gold_reward))
