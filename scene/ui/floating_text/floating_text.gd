extends Control


func start(text: String):
	$Label.text = text
	
	var tween = create_tween()
	tween.set_parallel()
	
	tween.tween_property(self, "global_position", global_position + (Vector2.UP * 16), 1.5)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "modulate", Color(1, 1, 1, 0), 1.5)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	
	tween.chain()
	
	tween.tween_callback(queue_free)
