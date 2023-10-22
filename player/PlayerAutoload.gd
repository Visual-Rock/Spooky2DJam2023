extends Node

signal candela_changed()
signal lux_changed()
signal player_max_speed_changed(speed: int)
signal player_stealth_factor_changed(stealth_factor: int)
signal player_won()

var candela : int = 20 : set = on_candela_set
var lux : int = 0 : set = on_lux_set

var max_candela : int = 20 : set = set_max_candela

func set_max_candela(val) -> void:
	max_candela = val
	emit_signal("candela_changed")

var lumen_collected : int = 0 : set = on_lumen_collected
var lumen_to_collect : int = 0

var player : CharacterBody2D

var player_max_speed : int = 500 : set = on_player_max_speed_changed
var player_stealth_factor : float = 1.0 : set = on_player_stealth_factor_changed

var light_strength_curve : Curve = load("res://assets/light_strength_curve.tres")

func get_light_strength() -> float:
	return light_strength_curve.sample(candela / max_candela)

func on_candela_set(value) -> void:
	candela = value
	emit_signal("candela_changed")

func on_lux_set(value) -> void:
	lux = value
	emit_signal("lux_changed")

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
	1: 0.95,
	2: 0.90,
	3: 0.80
}

func on_player_stealth_lvl_set(value):
	stealth_lvl = value
	player_stealth_factor = stealth_upgrades[value]

var shoes_lvl = 0 : set = on_player_shoes_lvl_set
var shoes_max_lvl = 3
var shoes_upgrades = {
	0: 500,
	1: 590,
	2: 680,
	3: 750
}

func on_player_shoes_lvl_set(value):
	shoes_lvl = value
	player_max_speed = shoes_upgrades[value]


func on_lumen_collected(value) -> void:
	lumen_collected = value
	if lumen_collected == lumen_to_collect:
		emit_signal("player_won")
