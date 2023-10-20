extends Node2D

var dialog_manager : DialogManager
var dialog : Dialog = null

# Called when the node enters the scene tree for the first time.
func _ready():
	dialog_manager = DialogManager.new()
	dialog_manager.load_dialogs("res://dialogs/Bakes/")
	dialog = dialog_manager.get_dialog("shop_dargan")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	print("Hello World")
	pass # Replace with function body.
