extends CharacterBody2D

@onready var AnimationPlayerNode : AnimationPlayer = get_node("AnimationPlayer")
@onready var Sprit : Sprite2D = get_node("Sprite2D")
@onready var TorchPosition : Marker2D = get_node("Marker2D")

var respawn_pos : Vector2
var dead : bool = false

var max_speed    : int = PlayerAutoload.player_max_speed
var FRICTION     : int = 4200
var ACCELERATION : int = 4200

func _ready():
	PlayerAutoload.player = self
	PlayerAutoload.connect("player_max_speed_changed", func(x): max_speed = x)
	respawn_pos = global_position

func _physics_process(delta):
	$"CanvasLayer/Control/FPS".text = "FPS: " + str(Engine.get_frames_per_second())
	if !dead:
		var direction = Input.get_vector("left", "right", "up", "down").normalized()
		if direction != Vector2.ZERO && max_speed != 0:
			Sprit.flip_h = direction.x < 0
			TorchPosition.position.x = -6 if direction.x < 0 else 6
			AnimationPlayerNode.play("walk")
			AnimationPlayerNode.speed_scale = 2.0
			velocity = velocity.move_toward(direction * max_speed, ACCELERATION * delta)
			queue_redraw()
		else:
			AnimationPlayerNode.play("idle")
			AnimationPlayerNode.speed_scale = 1.0
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		move_and_slide()

func kill() -> void:
	dead = true
	AnimationPlayerNode.speed_scale = 1.0
	AnimationPlayerNode.play("death")
	$"CollisionShape2D2".disabled = true

func reset() -> void:
	global_position = respawn_pos

func finished() -> void:
	dead = false
	$"CollisionShape2D2".disabled = false
