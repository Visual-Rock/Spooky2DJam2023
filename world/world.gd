extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().remove_child(Global.DialogOverlay)
	get_parent().add_child(Global.DialogOverlay)
	PlayerAutoload.connect("player_won", player_won)
	
	Console.add_command("set", _on_set_command, 2)
	Console.add_command("get", _on_get_command, 1)
	
	var tween = get_tree().create_tween()
	tween.tween_property($"CanvasLayer/Control/ColorRect", "color", Color(0, 0, 0, 0), 0.3)

func _on_set_command(param: String, param2: String) -> void:
	if param == "candela":
		PlayerAutoload.candela = int(param2)
	elif param == "speed":
		PlayerAutoload.player_max_speed = int(param2)
	elif param == "lux":
		PlayerAutoload.lux = int(param2)
	elif param == "stealth":
		PlayerAutoload.stealth_lvl = int(param2)

func _on_get_command(param: String) -> void:
	if param == "candela":
		Console.print_line(str(PlayerAutoload.candela))
	elif param == "speed":
		Console.print_line(str(PlayerAutoload.player_max_speed))
	elif param == "lux":
		Console.print_line(str(PlayerAutoload.lux))

func player_won() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($"CanvasLayer/Control/ColorRect", "color", Color.BLACK, 0.5)
	tween.tween_callback(func(): get_tree().change_scene_to_file("res://end_screen.tscn"))
