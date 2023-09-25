extends Node
class_name ItemPricerComponent

@onready var price_refresh_timer = $PriceRefreshTimer

var item_pricer = ItemPricer.get_random_pricer()


func _ready():
	price_refresh_timer.timeout.connect(on_refresh_timeout)
		
		
func on_refresh_timeout():
	print("refreshing item prices")
	item_pricer.randomize_rates()
