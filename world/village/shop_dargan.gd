extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("dialog_branch_selected", branch_selected)
	pass # Replace with function body.

func branch_selected(branch: Array):
	print(branch)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	Global.DialogOverlay.show_dialog("shop_dargan", {
		"price1": "ABC",
		"price2": "EFG",
		"test": "WHAT",
	})
