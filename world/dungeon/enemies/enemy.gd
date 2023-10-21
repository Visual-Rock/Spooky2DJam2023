extends CharacterBody2D

@export var speed : int = 500
@export var idle : AudioStream

func _ready():
	$"AudioStreamPlayer2D".stream = idle
	$"AudioStreamPlayer2D".play()


func _on_look_area_body_entered(body):
	if body.name == "player":
		pass
