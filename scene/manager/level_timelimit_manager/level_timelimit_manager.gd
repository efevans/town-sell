extends CanvasLayer

@onready var level_timer = %LevelTimer
@onready var update_timer = %UpdateTimer
@onready var clock := %Clock

var base_wait_time: float
var timer_fill_color := Color("FIREBRICK", 0.8)


func _ready():
	base_wait_time = level_timer.wait_time
	update_timer.timeout.connect(on_update_timeout)
	update_clock()
	
	
func update_clock():
	var time_remaining = level_timer.time_left
	clock.value =  1.0 - (time_remaining / base_wait_time)
	clock.tint_progress = timer_fill_color


func on_update_timeout():
	update_clock()
