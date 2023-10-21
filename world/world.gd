extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.init()
	
	Console.add_command("candela", _on_candela_command, 1)
	Console.add_command("get", _on_get_command, 1)

func _on_candela_command(param: String) -> void:
	var val = int(param)
	if val > PlayerAutoload.max_candela:
		PlayerAutoload.candela = PlayerAutoload.max_candela
	elif val < 0:
		PlayerAutoload.candela = 0
	else:
		PlayerAutoload.candela = val

func _on_get_command(param: String) -> void:
	if param == "candela":
		Console.print_line(str(PlayerAutoload.candela))
