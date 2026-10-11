extends StaticBody2D
class_name Plant
@onready var grow_component: Node2D = $GrowComponent
@onready var anim: AnimationPlayer = $AnimationPlayer
var is_grown: bool = false
var anim_path = "Plant Animations/"

func _ready() -> void:
	grow_component.fully_grown.connect(_on_grow_component_fully_grown)
	grow_component.grew.connect(_on_grow_component_grew)
	idle("Random")
	pass

# Pass "Random" for a random start, "" for start at beginning
func idle(location: String) -> void:
	anim.play(anim_path + "Idle", 0.2)
	anim.speed_scale = randf_range(0.9, 1.1)
	match location:
		"Random":
			anim.seek(randf() * anim.current_animation_length, true)

func grow() -> void:
	anim.play(anim_path + "Grow", 0.2)
	await anim.animation_finished
	idle("")

func _on_grow_component_fully_grown() -> void:
	is_grown = true

func _on_grow_component_grew() -> void:
	grow()
