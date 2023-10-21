extends Node

signal candela_changed()
signal player_max_speed_changed(speed: int)
signal player_stealth_factor_changed(stealth_factor: int)

var candela : int = 0 : set = on_candela_set
var lux : int = 400

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


var stealth_lvl = 0 : set = on_player_stealth_lvl_set
var stealth_max_lvl = 3
var stealth_upgrades = {
	0: 1,
	1: 0.8,
	2: 0.6,
	3: 0.4
}

func on_player_stealth_lvl_set(value):
	stealth_lvl = value
	player_stealth_factor = stealth_upgrades[value]

var shoes_lvl = 0 : set = on_player_shoes_lvl_set
var shoes_max_lvl = 3
var shoes_upgrades = {
	0: 500,
	1: 1000,
	2: 2000,
	3: 3000
}

func on_player_shoes_lvl_set(value):
	shoes_lvl = value
	player_max_speed = shoes_upgrades[value]
