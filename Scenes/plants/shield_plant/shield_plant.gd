extends Plant
@onready var shield_sprite: Sprite2D = $Pivot/ShieldSprite
@onready var plant_sprite: Sprite2D = $Pivot/PlantSprite
@onready var shield_collider: CollisionPolygon2D = $Shield/CollisionPolygon2D
@onready var shield_timer: Timer = $Shield/ShieldTimer

var SHIELDED_LENGTH = 5
var is_shield_launched = false

func _ready() -> void:
	super._ready()
	disable_shield()

func water() -> void:
	grow_component.water()
	if (grow_component.is_ready()):
		enable_shield()

func _on_shield_area_entered(area: Node) -> void:
	if (area.get_parent() is Plant):
		print("A plant is in the way!")
		return
	if (area.get_parent() is not Enemy):
		print("This is not an enemy!")
		return
	if (!is_shield_launched):
		launch_shield()
	area.die()

func launch_shield() -> void:
	is_shield_launched = true
	shield_sprite.visible = true
	plant_sprite.visible = false
	shield_timer.start(SHIELDED_LENGTH)
	is_shield_launched = true
	await get_tree().create_timer(SHIELDED_LENGTH - 2).timeout
	sprite_flash()

# Does not LAUNCH shield, just allows it to detect collisions
func enable_shield() -> void:
	shield_collider.set_deferred("disabled", false)

func disable_shield() -> void:
	shield_timer.stop()
	is_shield_launched = false
	shield_collider.set_deferred("disabled", true)
	shield_sprite.visible = false
	plant_sprite.visible = true

func _on_shield_timer_timeout() -> void:
	disable_shield()
	grow_component.harvested()

func sprite_flash() -> void:
	var tween: Tween = create_tween()
	tween.set_loops(4)
	tween.tween_property(shield_sprite, "modulate:v", 1, 0.25).from(15)
	tween.tween_interval(0.25)
