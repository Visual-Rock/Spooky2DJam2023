extends "res://world/dungeon/enemies/enemy.gd"


func _on_idle() -> void:
	$"AnimationPlayer".play("idle")

func _on_walk(direction: Vector2) -> void:
	$"Sprite2D".flip_h = direction.x < 0
	$"AnimationPlayer".play("walk")
