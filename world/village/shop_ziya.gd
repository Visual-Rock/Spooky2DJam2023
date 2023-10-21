extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("dialog_branch_selected", branch_selected)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func branch_selected(branch: Array):
	var value = branch[0]["value"]
	
	if value == "10 Candela > 3 Lux":
		_convert_candela(10, 3)
	elif value == "50 Candela > 17 Lux":
		_convert_candela(50, 17)
	elif value == "100 Candela > 36 Lux":
		_convert_candela(100, 36)
	pass

func _convert_candela(candela: int, to_lux: int):
	if (PlayerAutoload.candela < candela):
		Global.DialogOverlay.show_dialog("shop_ziya_missing_lumen", {})
		return false
	
	PlayerAutoload.candela -= candela
	PlayerAutoload.lux += to_lux
	return true
	

func _on_ziya_collision_area_area_entered(area):
	Global.DialogOverlay.show_dialog("shop_ziya", {
		"candela_amount": PlayerAutoload.candela
	})
	pass # Replace with function body.
