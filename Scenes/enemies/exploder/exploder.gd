extends Enemy
@onready var SPRITE: Sprite2D = $Sprite2D
const EXPLOSION = preload("uid://behf1ielot7mo")
@onready var level_base: Node2D = $"."
@onready var timer: Timer = $Timer
@export var distance_stop_at = 160 # distance the entity will stop at before going in quickly
var target
var speed
var FIRST_SPEED = 100
var SECOND_SPEED = 500
# speed is initialized to FIRST_SPEED in _ready()
# speed is stopped in move()
# speed is set to SECOND_SPEED once timer times out
# movement is based on move()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = FIRST_SPEED
	pass

func _process(delta: float) -> void:
	move(delta)
	pass

func explode() -> void:
	speed = 0 # stop entity
	SPRITE.texture = EXPLOSION
	await get_tree().create_timer(0.5).timeout
	queue_free()

func move(delta: float) -> void:
	var dir = (target.global_position - global_position).normalized() # Vector2 towards the target
	var remaining_distance = target.global_position - global_position # distance between the target and self
	if (remaining_distance.length() <= distance_stop_at):
		if (timer && timer.is_stopped()):
			timer.start()
			speed = 0
	position += dir * speed * delta

func _on_timer_timeout() -> void:
	speed = SECOND_SPEED
	timer.queue_free()

func die() -> void:
	explode()
