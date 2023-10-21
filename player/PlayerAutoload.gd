extends Node

signal candela_changed()
signal player_max_speed_changed(speed: int)
signal player_stealth_factor_changed(stealth_factor: int)

var candela : int = 0 : set = on_candela_set
var lux : int = 0

const max_candela : int = 100

var player : CharacterBody2D

var player_max_speed : int = 500 : set = on_player_max_speed_changed
var player_stealth_factor : float = 1.0 : set = on_player_stealth_factor_changed

var light_strength_curve : Curve = load("res://assets/light_strength_curve.tres")

func get_light_strength() -> float:
	return light_strength_curve.sample(candela / max_candela)

func on_candela_set(value) -> void:
	candela = value
	emit_signal("candela_changed")

func on_player_max_speed_changed(value) -> void:
	player_max_speed = value
	emit_signal("player_max_speed_changed", value)

func on_player_stealth_factor_changed(value) -> void:
	player_stealth_factor = value
	emit_signal("player_stealth_factor_changed", value)
