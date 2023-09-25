extends CanvasLayer

@onready var fps_label = %FPSLabel


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fps_label.text = "FPS: " + str(Engine.get_frames_per_second())
