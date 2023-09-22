class_name LineItemMenuInteractionControllerFactory

func create(type: LineItemMenu.Type, owner_inventory: Inventory):
	match type:
		LineItemMenu.Type.PLAYER_BUY:
			return PlayerBuyInteractionController.new().init(owner_inventory)
		LineItemMenu.Type.PLAYER_SELL:
			return PlayerSellInteractionController.new().init(owner_inventory)
		LineItemMenu.Type.SINGLE_CHOICE_BUY:
			return null
		_:
			return null
