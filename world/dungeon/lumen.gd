extends Node2D

const candela : int = 20

func _ready():
	PlayerAutoload.lumen_to_collect += 1
	PlayerAutoload.max_candela += candela
	PlayerAutoload.lumen_positions.append(global_position)
	$"Sprite2D".frame = randi_range(0, 2)

func _on_area_2d_body_entered(body):
	PlayerAutoload.candela += candela
	PlayerAutoload.lumen_collected += 1
	$"AnimationPlayer".play("collect")

func delte() -> void:
	queue_free()
