class_name LineItemMenuInteractionControllerFactory

func create(type: LineItemMenu.Type, owner: NPC):
	match type:
		LineItemMenu.Type.PLAYER_BUY:
			return PlayerBuyInteractionController.new().init(owner)
		LineItemMenu.Type.PLAYER_SELL:
			return PlayerSellInteractionController.new().init(owner)
		LineItemMenu.Type.SINGLE_CHOICE_BUY:
			return null
		_:
			return null
