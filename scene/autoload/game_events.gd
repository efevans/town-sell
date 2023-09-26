extends Node

signal interactable_opened
signal interactable_closed

signal gate_opened(gate: Gate)

signal cutscene_started
signal cutscene_ended


func emit_interactable_opened():
	interactable_opened.emit()


func emit_interactable_closed():
	interactable_closed.emit()


func emit_gate_opened(gate: Gate):
	gate_opened.emit(gate)
	
	
func emit_cutscene_started():
	cutscene_started.emit()
	
	
func emit_cutscene_ended():
	cutscene_ended.emit()
