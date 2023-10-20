extends Node

var DialogOverlay : CanvasLayer

func init():
	DialogOverlay = load("res://dialog_overlay.tscn").instantiate()
	get_parent().add_child.call_deferred(DialogOverlay)
