extends Node

signal candela_changed()

var candela : int = 0 : set = on_candela_set
var lux : int = 0

const max_candela : int = 100

var player : CharacterBody2D

var light_strength_curve : Curve = load("res://assets/light_strength_curve.tres")

func get_light_strength() -> float:
	return light_strength_curve.sample(candela / max_candela)

func on_candela_set(value) -> void:
	candela = value
	emit_signal("candela_changed")
