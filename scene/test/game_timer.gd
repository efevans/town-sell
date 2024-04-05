extends CanvasLayer

@onready var label = $Label
@onready var timer = $Timer

@export var level_timelimit_manager: LevelTimelimitManager


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.timeout.connect(on_timeout)
	

func update_time():
	label.text = "Timer: " + str(level_timelimit_manager.get_remaining_time())
	
	
func on_timeout():
#	var ticks = Time.get_ticks_msec()
#	label.text = "Timer: " + str(ticks / 1000.0)
	update_time()
