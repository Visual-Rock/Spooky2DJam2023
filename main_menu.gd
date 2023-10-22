extends Node2D

func _ready():
	Global.init()
	$"CanvasLayer/HSlider".value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))


func _process(delta):
	# $"Player".global_position = Vector2(640,360)
	pass

func _on_start_pressed():
	get_tree().change_scene_to_file("res://intro.tscn")


func _on_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
