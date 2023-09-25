extends CanvasLayer

@onready var label = $Label
@onready var timer = $Timer




# Called when the node enters the scene tree for the first time.
func _ready():
	timer.timeout.connect(on_timeout)
	
	
func on_timeout():
	var ticks = Time.get_ticks_msec()
	label.text = "Timer: " + str(ticks / 1000)
