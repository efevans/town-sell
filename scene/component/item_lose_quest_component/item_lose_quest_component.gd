extends Node

signal quest_completed

@export_group("Quest Properties")
@export var item_lose_requirements: Array[Item]

@export_group("Node Dependencies")
@export var inventory_component: InventoryComponent

@export_group("", "")

var lost_item_memory: ItemMemory


func _ready():
	inventory_component.inventory.item_removed.connect(on_item_lost)
	lost_item_memory = ItemMemory.new(item_lose_requirements.size())
	
	
func on_item_lost(item: Item):
	print("quest: noticed item lost")
	lost_item_memory.push(item)
	if lost_item_memory.matches(item_lose_requirements):
		print("quest completed, emitting signal")
		quest_completed.emit()
	
	
func print_pretty_item_array(arr: Array[Item]):
	for item in arr:
		print(item.id)
	

class ItemMemory:
	var memory: Array[Item]
	var max_size: int
	
	func _init(size: int):
		memory = []
		max_size = size


	func push(item: Item):
		memory.append(item)
		if (memory.size() > max_size):
			memory.pop_front()


	func matches(items: Array[Item]) -> bool:
		if items.size() != memory.size():
			return false
			
		for i in items.size():
			if items[i].id != memory[i].id:
				return false
				
		return true
		
		
		
		
		
		
		
