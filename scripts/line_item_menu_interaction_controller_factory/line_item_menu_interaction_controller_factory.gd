class_name LineItemMenuInteractionControllerFactory

func create(type: LineItemMenu.Type, npc: NPC):
	match type:
		LineItemMenu.Type.PLAYER_BUY:
			return PlayerBuyInteractionController.new().init(npc)
		LineItemMenu.Type.PLAYER_SELL:
			return PlayerSellInteractionController.new().init(npc)
		_:
			return null
