extends Node2D

var playing : bool = false

func _ready():
	Global.init()

func _process(delta):
	if !playing && Global.DialogOverlay.Main != null:
		Global.DialogOverlay.show_dialog("game_intro", {})
		Global.DialogOverlay.connect("dialog_ended", dialog_ended)
		playing = true

func dialog_ended() -> void:
	get_tree().change_scene_to_file("res://world/world.tscn")
