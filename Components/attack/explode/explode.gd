extends Attack

@export var hitbox: HitboxComponent

func _ready() -> void:
	attack_setup()
	hitbox.area_entered.connect(_on_hitbox_entered)

func attack() -> void:
	pass

func _on_hitbox_entered(area: Area2D) -> void:
	if (area.has_method("damage")):
		area.damage(self)
	parent.explode()
