extends Enemy
@onready var SPRITE: Sprite2D = $Sprite2D
@onready var level_base: Node2D = $"."
@onready var timer: Timer = $Timer
@export var distance_stop_at = 160 # distance the entity will stop at before going in quickly
@onready var anim: AnimationPlayer = $AnimationPlayer
const EXPLOSION = preload("uid://cfpup4hvq85de")

var target
var speed
var FIRST_SPEED = 100
var SECOND_SPEED = 500
enum {MOVE, WAIT, PREPARE, ATTACK}
var state = MOVE
# speed is initialized to FIRST_SPEED in _ready()
# speed is stopped in move()
# speed is set to SECOND_SPEED once timer times out
# movement is based on move()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("Move")
	if (target.global_position.x - position.x >= 0):
		# exploder is to the LEFT of target
		look_at(target.global_position)
	else:
		# exploder is to the RIGHT of target
		look_at(target.global_position)
		scale.y = -1
	speed = FIRST_SPEED
	update_state("MOVE")
	pass

func _process(delta: float) -> void:
	move(delta)
	pass

func explode() -> void:
	speed = 0 # stop entity
	SPRITE.texture = EXPLOSION
	SPRITE.region_rect = Rect2(0, 0, 41, 35)
	await get_tree().create_timer(0.5).timeout
	queue_free()

func move(delta: float) -> void:
	var dir = (target.global_position - global_position).normalized() # Vector2 towards the target
	var remaining_distance = target.global_position - global_position # distance between the target and self
	if (remaining_distance.length() <= distance_stop_at):
		if (timer && timer.is_stopped()):
			timer.start()
			speed = 0
			update_state("WAIT")
			await get_tree().create_timer(0.5).timeout
			update_state("PREPARE")
	position += dir * speed * delta

func _on_timer_timeout() -> void:
	speed = SECOND_SPEED
	update_state("ATTACK")
	timer.queue_free()

func die() -> void:
	explode()

# updates state AND sprite
func update_state(new_state: String) -> void:
	var x_position = 0
	if (new_state == "MOVE"):
		state = MOVE
	elif (new_state == "WAIT"):
		state = WAIT
		x_position = 41
	elif (new_state == "PREPARE"):
		state = PREPARE
		x_position = 82
	elif (new_state == "ATTACK"):
		state = ATTACK
		x_position = 123
	else:
		print("Invalid state!")
		update_state(state)
	SPRITE.region_rect = Rect2(x_position, 0, 41, 35)
