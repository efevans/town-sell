extends CanvasLayer

@onready var animation_player = %AnimationPlayer
@onready var panel_container = %PanelContainer
@onready var rich_text_label = %RichTextLabel

var is_fading_out: bool = false


func _ready():
	get_tree().create_timer(4).timeout.connect(fade_out)


func fade_out():
	if is_fading_out:
		return
	is_fading_out = true
	
	var tween = create_tween()
	
	tween.tween_property(panel_container, "modulate", Color(1, 1, 1, 0), 1.5)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	
	tween.tween_callback(queue_free)
