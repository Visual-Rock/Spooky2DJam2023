extends Node2D

@onready var Name = get_node("CanvasLayer/Control3/MarginContainer/HBoxContainer/Panel/MarginContainer/VBoxContainer/Name")
@onready var Text = get_node("CanvasLayer/Control3/MarginContainer/HBoxContainer/Panel/MarginContainer/VBoxContainer/Text")

var dialog : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property($"CanvasLayer/Control/ColorRect", "color", Color(0, 0, 0, 0), 0.3)
	tween.tween_callback(func(): ready())
	Global.init()

func proceed():
	match dialog:
		0:
			$"AnimationPlayer".play("battle")
		1:
			# play credits or back to menu
			pass
	dialog += 1

func ready() -> void:
	Global.DialogOverlay.connect("dialog_ended", proceed)

func first_dialog() -> void:
	Global.DialogOverlay.show_dialog("Game End", {})

func second_dialog() -> void:
	Global.DialogOverlay.show_dialog("Game End End", {})
