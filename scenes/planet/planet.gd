extends StaticBody2D
class_name Planet

@onready var game_start_pos := get_viewport_rect().size / 2.0
@onready var sprite: Sprite2D = $Sprite2D
@onready var plants: Node2D = $Plants
@onready var plant_timer: Timer = $PlantTimer
@export var health_component: HealthComponent
@export var hitbox_component: HitboxComponent

const PLANT = preload("res://Scenes/plant/plant.tscn")
var surface_offset # this is an OFFSET, not global position
var GROWING_SLOTS = 10 # number of plants that can grow
var MAX_PLANTS = 5 # number of plants allowed on planet
var free_spots: Array[int] = [] # array of 1 to GROWING_SLOTS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = game_start_pos
	surface_offset = Vector2(0, sprite.texture.get_width()/1.7)
	for i in range(0, GROWING_SLOTS):
		free_spots.append(i)
	spawn_plant()
	plant_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# TODO: make this not spawn every 5 seconds when its maxed out lol. stop the timer!
func spawn_plant() -> void:
	print(free_spots)
	if (free_spots.is_empty() || GROWING_SLOTS - free_spots.size() >= MAX_PLANTS) :
		# if out of spots OR num spots taken is > MAX_PLANTS
		print("Tried to plant new plant, all spots taken or hit max allowable plants.")
		return # skips to end
	var new_plant = PLANT.instantiate()
	plants.add_child(new_plant)
	var new_spot = free_spots.pick_random()
	free_spots.erase(new_spot) # TODO: remember to add it back once we harvest the plant
	new_plant.position = surface_offset.rotated((TAU / GROWING_SLOTS) * new_spot)
	new_plant.look_at(position)
	new_plant.rotate(-PI/2)
	new_plant.tree_exiting.connect(_on_plant_removed.bind(new_spot))
	print("Planted plant @: ", new_plant.position)

func _on_plant_removed(spot: int) -> void:
	free_spots.append(spot) # add the freed spot back into the list of free spots!
	pass

func _on_plant_timer_timeout() -> void:
	spawn_plant()
	plant_timer.start(randf_range(1, 5))
