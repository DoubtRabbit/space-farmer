extends Node2D

signal grew

@onready var growth_cooldown: Timer = $GrowthCooldown
@export var sprite: Sprite2D
@export var time_to_water: float
enum {SEEDLING, SPROUT, MATURE, READY}
var state = SEEDLING
var thirsty: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	growth_cooldown.start(time_to_water)
	update_sprite()

func water() -> void:
	if (!thirsty):
		return
	grow_plant()

func is_ready() -> bool:
	return (state == READY)

func grow_plant() -> void:
	if (state == SEEDLING):
		state = SPROUT
		disable_thirsty()
		growth_cooldown.start(time_to_water)
	elif (state == SPROUT):
		state = MATURE
		disable_thirsty()
		growth_cooldown.start(time_to_water)
	elif (state == MATURE):
		state = READY
		disable_thirsty()
	elif (state == READY):
		print("Tried to grow a plant that is already READY!")
		pass
	grew.emit()

func harvested() -> void:
	state = MATURE
	enable_thirsty()

func _on_growth_cooldown_timeout() -> void:
	enable_thirsty()

func disable_thirsty() -> void:
	thirsty = false
	update_sprite()

func enable_thirsty() -> void:
	thirsty = true
	update_sprite()

func update_sprite() -> void:
	var x_position
	if (state == SEEDLING):
		x_position = 0
	elif (state == SPROUT):
		x_position = 96
	elif (state == MATURE || state == READY):
		x_position = 192
	if (thirsty):
		x_position += 48
	sprite.region_rect = Rect2(x_position, 0, 48, 48)
