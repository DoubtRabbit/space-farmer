extends Node2D
class_name HealthComponent

@export var MAX_HEALTH: float
var health: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = MAX_HEALTH

func damage(attack: Attack) -> void:
	health -= attack.ATTACK_DAMAGE
	print("Did ", attack, "! Health: ", health)
	if (get_parent() is Planet):
		SignalHub.planet_damaged.emit()
	if health <= 0:
		var parent = get_parent()
		if (parent.has_method("die")):
			parent.die()
		else:
			parent.queue_free()
			
