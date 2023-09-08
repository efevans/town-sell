extends Node

signal npc_menu_opened
signal npc_menu_closed


func emit_npc_menu_opened():
	npc_menu_opened.emit()


func emit_npc_menu_closed():
	npc_menu_closed.emit()
