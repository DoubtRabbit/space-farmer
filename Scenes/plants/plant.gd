extends Area2D
class_name Plant
@onready var grow_component: Node2D = $GrowComponent
@onready var anim: AnimationPlayer = $AnimationPlayer
var anim_path = "Plant Animations/"

func _ready() -> void:
	idle("Random")
	grow_component.grew.connect(grow)
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
