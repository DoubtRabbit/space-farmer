extends StaticBody2D
class_name Plant

const STATE_0 = preload("uid://dsk30b8hdgyxv")
const STATE_1 = preload("uid://di3127qi3e7e3")
const STATE_2 = preload("uid://bdim5resiwutq")
var growth_state = 1 # track growth state
var thirsty = true

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
	print("Attempting to grow from growth state ", growth_state)
	if (thirsty):
		disable_thirsty()
		growth_cooldown.start(randf_range(3, 10))
		match growth_state:
			0:
				sprite.texture = STATE_0
				growth_state += 1
				print("Grew plant to growth state ", growth_state)
			1:
				sprite.texture = STATE_1
				growth_state += 1
				print("Grew plant to growth state ", growth_state)
			2:
				sprite.texture = STATE_2
				growth_state += 1
				print("Plant finished growing!")
			3: 
				harvest_plant()
				print("Plant harvested!")

func harvest_plant() -> void:
	queue_free()
	SignalHub.plant_harvested.emit()

func water() -> void:
	grow_plant()

func enable_thirsty() -> void:
	thirsty = true
	thirsty_icon.visible = true
	
	
func disable_thirsty() -> void:
	thirsty = false
	thirsty_icon.visible = false

func _on_growth_cooldown_timeout() -> void:
	enable_thirsty()
