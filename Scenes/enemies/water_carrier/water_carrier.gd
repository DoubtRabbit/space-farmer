extends RigidBody2D

@export var hitbox_component: HitboxComponent
@onready var player: CharacterBody2D = $"/root/LevelBase/Player"
@onready var SPRITE: Sprite2D = $Sprite2D


@export var WATER_QUANTITY: float
@export var SPEED: float
var FREQUENCY
var time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_water()
	SPEED = randf_range(50, 100)
	FREQUENCY = randf_range(3, 5)
	time = 0

func set_water() -> void:
	WATER_QUANTITY = randf_range(10, 50)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += sin(time * FREQUENCY)
	position.y -= SPEED * delta
	if (time > 10): # timeout if too long / off screen TODO: better
		hitbox_component.queue_free()
		queue_free()
	time += delta
	pass

func die() -> void:
	player.collect_water(WATER_QUANTITY)
	SPRITE.region_rect = Rect2(32, 0, 32, 32)
	set_process(false)
	hitbox_component.queue_free()
	await get_tree().create_timer(0.3).timeout
	queue_free()
