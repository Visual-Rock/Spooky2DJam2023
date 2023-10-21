extends CharacterBody2D

@onready var AnimationPlayerNode : AnimationPlayer = get_node("AnimationPlayer")
@onready var Sprit : Sprite2D = get_node("Sprite2D")
@onready var TorchPosition : Marker2D = get_node("Marker2D")

var max_speed    : int = 500
var FRICTION     : int = 4200
var ACCELERATION : int = 4200

func _ready():
	PlayerAutoload.player = self

func _physics_process(delta):
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

func _draw():
	draw_circle(TorchPosition.position, 10.0, Color.AQUA)
