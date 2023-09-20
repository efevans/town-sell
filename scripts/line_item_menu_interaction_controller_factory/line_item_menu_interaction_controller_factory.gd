class_name LineItemMenuInteractionControllerFactory

func create(type: LineItemMenu.Type, owner_entity):
	match type:
		LineItemMenu.Type.PLAYER_BUY:
			return PlayerBuyInteractionController.new().init(owner_entity)
		LineItemMenu.Type.PLAYER_SELL:
			return PlayerSellInteractionController.new().init(owner_entity)
		_:
			return null
