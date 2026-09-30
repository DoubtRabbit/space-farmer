extends Node2D
const EXPLODER = preload("uid://cgjxxpjcg8jbl")
@onready var planet: Planet = $"../Planet"
const WATER_CARRIER = preload("uid://c3us3rpkhgs2k")
@onready var marker_2d: Marker2D = $Marker2D
@onready var marker_2d_2: Marker2D = $Marker2D2
@onready var marker_2d_4: Marker2D = $Marker2D4
@onready var marker_2d_3: Marker2D = $Marker2D3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_timer_timeout() -> void:
	print("timeout")
	var random = randi_range(0, 1)
	var random2 = randi_range(0, 3)
	var entity
	if (random == 0):
		entity = EXPLODER.instantiate()
		entity.target = planet
	else:
		entity = WATER_CARRIER.instantiate()
	if (random2 == 0):
		entity.position = marker_2d.position
	elif (random2 == 1):
		entity.position = marker_2d_2.position
	elif (random2 == 2):
		entity.position = marker_2d_3.position
	elif (random2 == 3):
		entity.position = marker_2d_4.position
	add_child(entity)
