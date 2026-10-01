extends StaticBody2D
class_name Plant
const BASIC_FLOWER = preload("uid://bcx5emhwrx1v3")
var growth_state = -1 # track growth state
var thirsty = true

# TODO: use enums

@onready var thirsty_icon: Sprite2D = $ThirstyIcon
@onready var sprite: Sprite2D = $Sprite2D
@onready var growth_cooldown: Timer = $GrowthCooldown

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func grow_plant() -> void:
	if (thirsty):
		disable_thirsty()
		growth_state += 1
		growth_cooldown.start(randf_range(3, 10))
		match growth_state:
			0:
				sprite.region_rect = Rect2(0, 0, 48, 48)
				print("Grew plant to growth state ", growth_state)
			2:
				sprite.region_rect = Rect2(96, 0, 48, 48)
				print("Grew plant to growth state ", growth_state)
			4:
				sprite.region_rect = Rect2(192, 0, 48, 48)
				print("Plant finished growing!")
			6: 
				harvest_plant()
				print("Plant harvested!")

func harvest_plant() -> void:
	queue_free()
	SignalHub.plant_harvested.emit()

func water() -> void:
	grow_plant()

func enable_thirsty() -> void:
	thirsty = true
	#thirsty_icon.visible = true
	growth_state += 1
	print(growth_state)
	match growth_state:
			0:
				sprite.region_rect = Rect2(48, 0, 48, 48)
			1:
				sprite.region_rect = Rect2(144, 0, 48, 48)
			3:
				sprite.region_rect = Rect2(240, 0, 48, 48)
			5:
				sprite.region_rect = Rect2(192, 0, 48, 48)
	
	
func disable_thirsty() -> void:
	thirsty = false
	#thirsty_icon.visible = false

func _on_growth_cooldown_timeout() -> void:
	enable_thirsty()
