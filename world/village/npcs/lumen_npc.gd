extends Node2D


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		if PlayerAutoload.lumen_collected == 0:
			Global.DialogOverlay.show_dialog("lumen_no_saved", {})
		else:
			Global.DialogOverlay.show_dialog("lumen_some_saved", {"lumen_collected": PlayerAutoload.lumen_collected, "lumen_needed": PlayerAutoload.lumen_to_collect - PlayerAutoload.lumen_collected})
