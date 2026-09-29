extends Control
@onready var player: CharacterBody2D = $"../../Player"
@onready var money_label: Label = $MarginContainer/Money
@onready var water_bar: ProgressBar = $Water

var money
var PLANT_MONEY = 5 # default amount of money harvested

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	money = 0
	money_label.text = str(money)
	water_bar.max_value = player.WATER_CAPACITY
	water_bar.min_value = 0.0
	water_bar.value = player.current_water
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# TODO: create a specific money manager?
func on_plant_harvested() -> void:
	print("HARVESTED")
	money += PLANT_MONEY
	money_label.text = str(money)
	print("Gained ", PLANT_MONEY, " now have: ", money)


func _on_tree_entered() -> void:
	SignalHub.plant_harvested.connect(on_plant_harvested)
	SignalHub.water_shot.connect(on_water_shot)

func on_water_shot() -> void:
	water_bar.value = player.current_water
	
