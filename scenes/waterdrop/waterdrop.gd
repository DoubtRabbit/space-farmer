extends Area2D

var SPEED = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.DOWN.rotated(rotation) * SPEED # move in direction of its rotation
	position += velocity * delta
	pass

func _on_body_entered(body: Node2D) -> void:
	if body is Planet:
		queue_free() # destroy if hits planet
	elif body is Plant:
		body.water()
	pass # Replace with function body.
