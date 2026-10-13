extends Node2D

const EXPLODER = preload("uid://cgjxxpjcg8jbl")

@onready var timer: Timer = $ExploderTimer

@export var target: Planet
@export var min_time: float
@export var max_time: float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()

func _on_exploder_timer_timeout() -> void:
	create_new_exploder()
	var new_time = randf_range(min_time, max_time) 
	timer.start(new_time)

func create_new_exploder() -> void:
	var entity = EXPLODER.instantiate()
	entity.position = new_exploder_position()
	entity.target = target
	add_child(entity)

func new_exploder_position() -> Vector2:
	var random = randi_range(0, 3)
	var new_pos = Vector2()
	var screen_width = get_viewport_rect().size.x 
	var screen_height = get_viewport_rect().size.y
	match (random):
		0: # top
			new_pos.x = randf_range(0, screen_width)
			new_pos.y = -50
		1: # bottom
			new_pos.x = randf_range(0, screen_width)
			new_pos.y = screen_height + 50
		2: # left
			new_pos.x = -50
			new_pos.y = randf_range(0, screen_height)
		3: # right
			new_pos.x = screen_width + 50
			new_pos.y = randf_range(0, screen_height)
	return new_pos
