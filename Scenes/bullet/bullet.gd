extends Area2D

@export var SPEED := 200
var attack_damage 

var direction: float
var spawn_position: Vector2
var spawn_rotation: float

func _ready() -> void:
	global_position = spawn_position
	global_rotation = spawn_rotation
	print(spawn_position, global_position)

# TODO: delete if too far btw!!!!!!
func _process(delta: float) -> void:
	var velocity = Vector2(0, -SPEED).rotated(direction)
	position += velocity * delta
