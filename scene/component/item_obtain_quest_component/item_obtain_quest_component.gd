extends Node

@export_group("Quest Properties")
@export var item_reward: Item
@export var item_obtain_requirements: Array[Item]

@export_group("Node Dependencies")
@export var inventory_component: InventoryComponent

@export_group("", "")

var obtained_item_memory: ItemMemory


func _ready():
	inventory_component.inventory.item_added.connect(on_item_added)
	obtained_item_memory = ItemMemory.new(item_obtain_requirements.size())
	
	
func on_item_added(item: Item):
	print("quest: noticed item added")
	obtained_item_memory.push(item)
	if obtained_item_memory.matches(item_obtain_requirements):
		print("quest complete!")
	
	
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
		
		
		
		
		
		
		
