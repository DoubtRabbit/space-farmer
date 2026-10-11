extends Plant
@onready var shield: RigidBody2D = $Shield
@onready var shield_collider: CollisionPolygon2D = $Shield/CollisionPolygon2D

func _ready() -> void:
	shield_collider.disabled = true

func water() -> void:
	if (is_grown):
		ready_shield()
	else:
		grow_component.water()

func ready_shield() -> void:
	shield_collider.disabled = false
