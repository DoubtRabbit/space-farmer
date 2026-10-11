extends Node2D

signal fully_grown
signal grew

@onready var growth_cooldown: Timer = $GrowthCooldown
@export var sprite: Sprite2D
@export var time_to_water: float
@export var MAX_STATE = 0
var thirsty: bool = true
var growth_state: int = 0
var is_grown = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func water() -> void:
	if (growth_state < MAX_STATE):
		grow_plant()

func grow_plant() -> void:
	if (thirsty):
		disable_thirsty()
		growth_state += 1
		grew.emit()
		if (growth_state == MAX_STATE && !is_grown): 
			fully_grown.emit() # first time being fully grown!
			is_grown = true
		growth_cooldown.start(time_to_water)

func _on_growth_cooldown_timeout() -> void:
	enable_thirsty()

func disable_thirsty() -> void:
	thirsty = false
	match growth_state:
		0: 
			sprite.region_rect = Rect2(0, 0, 48, 48)
		1:
			sprite.region_rect = Rect2(96, 0, 48, 48)
		2:
			sprite.region_rect = Rect2(192, 0, 48, 48)

func enable_thirsty() -> void:
	thirsty = true
	match growth_state:
		0:
			sprite.region_rect = Rect2(48, 0, 48, 48)
		1:
			sprite.region_rect = Rect2(144, 0, 48, 48)
		2:
			sprite.region_rect = Rect2(240, 0, 48, 48)
		_:
			print("no thirsty growth state ", growth_state, " for ", self)
