extends RigidBody2D

@export var hitbox_component: HitboxComponent
@onready var player: CharacterBody2D = $"/root/LevelBase/Player"
@onready var SPRITE: Sprite2D = $Sprite2D


var WATER_QUANTITY

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_water()

func set_water() -> void:
	WATER_QUANTITY = randf_range(10, 50)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func die() -> void:
	player.collect_water(WATER_QUANTITY)
	SPRITE.region_rect = Rect2(32, 0, 32, 32)
	await get_tree().create_timer(0.3).timeout
	queue_free()
