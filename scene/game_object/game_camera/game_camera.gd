extends Camera2D

enum TARGETING_MODE {PLAYER, MENU}

const MENU_MODE_OFFSET = Vector2.UP * 30

@onready var animation_player = $AnimationPlayer

var target_position = Vector2.ZERO
var targeting_mode = TARGETING_MODE.PLAYER


func _ready():
	make_current()
	GameEvents.npc_menu_opened.connect(on_npc_menu_opened)
	GameEvents.npc_menu_closed.connect(on_npc_menu_closed)


func _process(delta):
	acquire_target()
	global_position = global_position.lerp(target_position, 1.0 - exp(-delta * 20))


func acquire_target():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	if targeting_mode == TARGETING_MODE.PLAYER:
		target_position = player.global_position
	elif targeting_mode == TARGETING_MODE.MENU:
		target_position = player.global_position + MENU_MODE_OFFSET
		
		
func on_npc_menu_opened():
#	zoom = Vector2(2, 2)
	animation_player.play("menu_zoom")
	targeting_mode = TARGETING_MODE.MENU
	
	
func on_npc_menu_closed():
#	zoom = Vector2.ONE
	animation_player.play_backwards("menu_zoom")
	targeting_mode = TARGETING_MODE.PLAYER
