extends Node2D


func _process(delta):
	$"Player".global_position = Vector2(640,360)

func _on_start_pressed():
	get_tree().change_scene_to_file("res://intro.tscn")
