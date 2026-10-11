extends Node2D

const WATER_CARRIER = preload("uid://c3us3rpkhgs2k")
const WATER_CARRIER_BIG = preload("uid://7eoeoxrdt004")

@onready var timer: Timer = $BubbleTimer

@export var target: Planet
@export var min_time: float
@export var max_time: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_bubble_timer_timeout() -> void:
	create_new_bubble()
	var new_time = randi_range(min_time, max_time) 
	timer.start(new_time)

func create_new_bubble() -> void:
	var entity = choose_bubble_size()
	entity.position = new_bubble_position()
	add_child(entity)

func choose_bubble_size() -> Node2D:
	var rand_num = randi_range(0, 100)
	var entity
	if (rand_num > 30):
		entity = WATER_CARRIER.instantiate()
	else:
		entity = WATER_CARRIER_BIG.instantiate()
	return entity

func new_bubble_position() -> Vector2:
	var new_pos = Vector2();
	var target_width = target.sprite.texture.get_width()
	var screen_width = get_viewport_rect().size.x 
	var spacing = 50 # extra spacing distance from the side of the planet
	var no_target_half_width = ((screen_width - target_width) / 2) - spacing # this is half the width of the total X length without the planet
	var offset = randf_range(-no_target_half_width, no_target_half_width) # pick either left or right side (offset from middle of planet)
	if (offset > 0):
		new_pos.x = offset
	else:
		new_pos.x = screen_width - offset
	new_pos.y = get_viewport_rect().size.y
	return new_pos
