extends CharacterBody2D
@onready var projectiles: Node2D = $"../Projectiles"
@onready var planet: StaticBody2D = $"../Planet"
const WATERDROP = preload("uid://jvuv42xdo6mt")

@export var attack: Attack

var speed = 2 # this is in radians
var CONSTANT_SPEED = 2
var distance = 125
var WATER_CAPACITY = 100
var current_water
var WATER_SHOT = 10 # quantity of water each shot takes

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = planet.global_position + Vector2(0, -distance)
	current_water = WATER_CAPACITY # start with max
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var center = planet.global_position
	var movement = Input.get_axis("LEFT", "RIGHT") * speed
	global_position = center + (position - center).rotated(movement * delta)
	look_at(center)
	rotate(-PI/2)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("WATER"):
		shoot_water()
	if event.is_action_pressed("ATTACK"):
		attack.attack()

func collect_water(quantity: float):
	if (current_water + quantity > WATER_CAPACITY):
		current_water = WATER_CAPACITY
	else:
		current_water += quantity
	SignalHub.water_collected.emit()

func shoot_water():
	if (current_water - WATER_SHOT >= 0):
		# if enough water
		current_water -= WATER_SHOT
		var new_drop = WATERDROP.instantiate()
		new_drop.rotation = rotation # same direction as player
		new_drop.position = position
		projectiles.add_child(new_drop)
		SignalHub.water_shot.emit()
	elif (current_water - WATER_SHOT < 0):
		# not enough water
		print("Not enough water to shoot!")
