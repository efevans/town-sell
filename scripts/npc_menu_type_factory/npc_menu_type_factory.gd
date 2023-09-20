class_name NPCMenuTypeFactory

static var line_item_menu_scene = preload(GameStrings.LINE_ITEM_MENU_SCENE_PATH)
static var single_choice_menu_scene = preload("res://scene/ui/single_choice_menu/single_choice_menu.tscn")

static func create(type: NPCMenu.Type):
	match type:
		NPCMenu.Type.LINE_ITEM:
			return line_item_menu_scene.instantiate()
		NPCMenu.Type.SINGLE_CHOICE:
			return single_choice_menu_scene.instantiate()
		_:
			return null
