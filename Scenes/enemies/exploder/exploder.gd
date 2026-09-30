extends StaticBody2D
@onready var SPRITE: Sprite2D = $Sprite2D
const EXPLOSION = preload("uid://behf1ielot7mo")
@onready var level_base: Node2D = $"."

var target
var SPEED = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var direction = target.global_position - global_position
	var velocity = direction.normalized() * SPEED
	position += velocity * delta

func explode() -> void:
	SPEED = 0
	SPRITE.texture = EXPLOSION
	await get_tree().create_timer(0.5).timeout
	queue_free()
