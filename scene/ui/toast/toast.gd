extends CanvasLayer
class_name Toast

@onready var animation_player = %AnimationPlayer
@onready var panel_container = %PanelContainer
@onready var rich_text_label = %RichTextLabel

var is_fading_out: bool = false

var item_format_string: String = "Obtained [img=b,b]%s[/img][color=%s]%s[/color]"
var gold_format_string: String = "Obtained %d [img=b,b]res://assets/sprites/gold_icon.png[/img][color=MOCCASIN]GOLD[/color]"


func _ready():
	get_tree().create_timer(4).timeout.connect(fade_out)


func set_subject(subject) -> Toast:
	if subject is Item:
		print("Toast: initializing for item")
		set_rich_text_label_for_item(subject as Item)
	elif subject is int:
		print("Toast: initializing for gold")
		set_rich_text_label_for_gold(subject as int)
	else:
		print("unrecognized toast subject")
		
	return self
	
	
func set_rich_text_label_for_item(item: Item):
	rich_text_label.text = ""
	rich_text_label.append_text(item_format_string % \
	[item.icon.resource_path, item.text_color_html(), item.name])
	pass
	
	
func set_rich_text_label_for_gold(amount: int):
	rich_text_label.text = ""
	rich_text_label.append_text(gold_format_string % amount)
	pass


func fade_out():
	if is_fading_out:
		return
	is_fading_out = true
	
	var tween = create_tween()
	
	tween.tween_property(panel_container, "modulate", Color(1, 1, 1, 0), 1.5)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	
	tween.tween_callback(queue_free)
