class_name NPCMenuTypeFactory

static var line_item_menu_scene = preload(GameStrings.LINE_ITEM_MENU)

static func create(type: NPCMenu.Type):
	match type:
		NPCMenu.Type.LINE_ITEM:
			return line_item_menu_scene.instantiate()
		_:
			return null
