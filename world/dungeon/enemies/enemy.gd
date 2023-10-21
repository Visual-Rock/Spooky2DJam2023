extends CharacterBody2D

@export var speed : int = 500
@export var FRICTION     : int = 4200
@export var ACCELERATION : int = 4200

@export var idle : AudioStream
@export var track : AudioStream
@export var track_radius : int = 45
@export var track_duration : float = 1.0 

@export var follow_player : bool = true

var track_player : bool = false

func _ready():
	$"AudioStreamPlayer2D".stream = idle
	$"AudioStreamPlayer2D".play()
	
	PlayerAutoload.connect("player_stealth_factor_changed", change_radius)

func change_radius(factor: float) -> void:
	var circle := CircleShape2D.new()
	circle.radius = track_radius * factor
	$"LookArea/CollisionShape2D".shape = circle

func _physics_process(delta):
	if follow_player:
		if track_player:
			var direction = position.direction_to(PlayerAutoload.player.position)
			velocity = velocity.move_toward(direction * speed, ACCELERATION * delta)
			_on_walk(direction)
		else:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			_on_idle()
		move_and_slide()

func _on_look_area_body_entered(body):
	if body.name == "Player":
		track_player = true
		$"AudioStreamPlayer2D".stream = track
		$"AudioStreamPlayer2D".play()
		$"TrackTimer".stop()

func _on_look_area_body_exited(body):
	if body.name == "Player":
		if $"TrackTimer":
			$"TrackTimer".start(track_duration)

func _on_track_timer_timeout():
	track_player = false
	$"AudioStreamPlayer2D".stream = idle
	$"AudioStreamPlayer2D".play()

func _on_idle() -> void:
	pass

func _on_walk(_velocity: Vector2) -> void:
	pass

func _on_kill_area_body_entered(body):
	if body.name == "Player":
		body.kill.call_deferred()
		self.queue_free()
