extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property($"CanvasLayer/Control/ColorRect", "color", Color(0, 0, 0, 0), 0.3)
	tween.tween_callback(func(): ready())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func ready() -> void:
	pass
