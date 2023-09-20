extends Node

signal interactable_opened
signal interactable_closed


func emit_interactable_opened():
	interactable_opened.emit()


func emit_interactable_closed():
	interactable_closed.emit()
