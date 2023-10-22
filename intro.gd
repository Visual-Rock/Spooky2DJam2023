extends Node2D

var playing : bool = false

func _ready():
	Global.init()
	var tween = get_tree().create_tween()
	tween.tween_property($"CanvasLayer/Control/ColorRect", "color", Color(0, 0, 0, 0), 0.5)
	tween.tween_callback(func(): ready())

func ready():
	Global.DialogOverlay.show_dialog("game_intro", {})
	Global.DialogOverlay.connect("dialog_ended", dialog_ended)

func dialog_ended() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($"CanvasLayer/Control/ColorRect", "color", Color.BLACK, 0.5)
	tween.tween_callback(func(): get_tree().change_scene_to_file("res://world/world.tscn"))
