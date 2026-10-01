extends Node2D
const EXPLODER = preload("uid://cgjxxpjcg8jbl")
@onready var planet: Planet = $"../Planet"
const WATER_CARRIER = preload("uid://c3us3rpkhgs2k")
const WATER_CARRIER_BIG = preload("uid://7eoeoxrdt004")
@onready var bubble_timer: Timer = $BubbleTimer
@onready var marker_2d: Marker2D = $Marker2D
@onready var marker_2d_2: Marker2D = $Marker2D2
@onready var marker_2d_4: Marker2D = $Marker2D4
@onready var marker_2d_3: Marker2D = $Marker2D3

@export var min_bubble_time: int
@export var max_bubble_time: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bubble_timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_bubble_timer_timeout() -> void:
	var rand_num = randi_range(0, 100)
	var entity
	if (rand_num > 30):
		entity = WATER_CARRIER.instantiate()
	else:
		entity = WATER_CARRIER_BIG.instantiate()
	
	var planet_width = planet.sprite.texture.get_width()
	var screen_width = get_viewport_rect().size.x 
	var spacing = 50 # extra spacing distance from the side of the planet
	var no_planet_half_width = ((screen_width - planet_width) / 2) - spacing # this is half the width of the total X length without the planet
	var offset = randf_range(-no_planet_half_width, no_planet_half_width) # pick either left or right side (offset from middle of planet)
	if (offset > 0):
		entity.position.x = offset
	else:
		entity.position.x = screen_width - offset
	entity.position.y = get_viewport_rect().size.y
	get_parent().add_child(entity)
	var new_time = randi_range(min_bubble_time, max_bubble_time) 
	bubble_timer.start(new_time)


func _on_timer_timeout() -> void:
	print("timeout")
	var random = randi_range(0, 3)
	var entity = EXPLODER.instantiate()
	entity.target = planet
	if (random == 0):
		entity.position = marker_2d.position
	elif (random == 1):
		entity.position = marker_2d_2.position
	elif (random == 2):
		entity.position = marker_2d_3.position
	elif (random == 3):
		entity.position = marker_2d_4.position
	add_child(entity)
