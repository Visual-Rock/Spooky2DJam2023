extends CanvasLayer

signal dialog_ended()
signal branch_selected(branch: Dictionary)

@onready var Main : Control = get_node("Control")

@onready var NameLabel : Label = get_node("Control/MarginContainer/HBoxContainer/Panel/MarginContainer/VBoxContainer/Name")
@onready var TextLabel : RichTextLabel = get_node("Control/MarginContainer/HBoxContainer/Panel/MarginContainer/VBoxContainer/Text")

@onready var Branches : VBoxContainer = get_node("Control/MarginContainer/HBoxContainer/Branches")

var dialog_manager : DialogManager
var dialog : Dialog 

func _ready():
	dialog_manager = DialogManager.new()
	dialog_manager.load_dialogs("res://dialogs/Bakes/")
	Main.visible = false

func show_dialog(dialog_name: String, values: Dictionary) -> void:
	Main.visible = true
	if PlayerAutoload.player:
		PlayerAutoload.player.max_speed = 0
	dialog = dialog_manager.get_dialog(dialog_name)
	dialog.restart()
	dialog.injection_data = values
	update()

func _input(event):
	if event.is_action_pressed("dialog_next"):
		if dialog && dialog.current_node_type() != Dialog.DialogNodeTypes.Branch:
			if dialog.current_node_type() == Dialog.DialogNodeTypes.End:
				dialog = null
				Main.visible = false
				emit_signal("dialog_ended")
				if PlayerAutoload.player:
					PlayerAutoload.player.max_speed = PlayerAutoload.player_max_speed
				return
			dialog.advance()
			update()

func update() -> void:
	if dialog == null:
		Main.visible = false
		emit_signal("dialog_ended")
		if PlayerAutoload.player:
			PlayerAutoload.player.max_speed = PlayerAutoload.player_max_speed
		return
	
	for branch in Branches.get_children():
		branch.queue_free()
	
	if dialog.current_node_type() == Dialog.DialogNodeTypes.Branch:
		var branches = dialog.get_branches()
		for branch in range(0, dialog.get_branches_count()):
			var btn = Button.new()
			btn.text = dialog.get_branch_value(branch, "Text")
			btn.connect("pressed", _on_dialog_branch_pressed)
			Branches.add_child(btn)
	
	NameLabel.text = dialog.get_value("Name")
	TextLabel.text = dialog.get_value("Text")

func _on_dialog_branch_pressed() -> void:
	var i : int = 0
	for branch in Branches.get_children():
		if branch.button_pressed:
			break
		i += 1
	
	emit_signal("branch_selected", dialog.get_branch(i))
	dialog.advance(i)
	update()
