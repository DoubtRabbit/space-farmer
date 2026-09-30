extends Attack

const BULLET = preload("uid://rqolslqws7yd")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	attack_setup()

func attack() -> void:
	if (can_attack):
		var bullet = BULLET.instantiate()
		bullet.direction = global_rotation
		bullet.spawn_position = global_position
		bullet.spawn_rotation = global_rotation 
		bullet.attack_damage = ATTACK_DAMAGE
		bullet.area_entered.connect(hit_entity.bind(bullet))
		get_node("/root/LevelBase/Projectiles").add_child(bullet)
		start_timer()

func hit_entity(area, bullet):
	if area.has_method("damage") && (area.get_parent() != parent):
		area.damage(self)
		bullet.queue_free()
