@abstract
extends Node2D
class_name Attack

@export var ATTACK_DAMAGE: float
@export var ATTACK_COOLDOWN: float
@export var cooldown_timer: Timer
@export var can_attack := true
@export var parent: Node

func attack_setup() -> void:
	cooldown_timer = Timer.new()
	add_child(cooldown_timer)
	cooldown_timer.timeout.connect(_on_timer_timeout)
	parent = get_parent()

func _on_timer_timeout() -> void:
	can_attack = true

func start_timer() -> void:
	can_attack = false
	cooldown_timer.start(ATTACK_COOLDOWN)

@abstract func attack()
