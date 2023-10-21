extends Node2D

func _ready():
	$"Sprite2D".frame = randi_range(0, 2)

func _on_area_2d_body_entered(body):
	PlayerAutoload.candela += 3
	queue_free()
