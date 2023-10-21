extends Node

signal finished_init()
signal dialog_branch_selected(dict: Dictionary)

var DialogOverlay : CanvasLayer

func init():
	DialogOverlay = load("res://dialog_overlay.tscn").instantiate()
	get_parent().add_child.call_deferred(DialogOverlay)
	DialogOverlay.connect("branch_selected", branch_selected)

func branch_selected(dict):
	emit_signal("dialog_branch_selected", dict)
