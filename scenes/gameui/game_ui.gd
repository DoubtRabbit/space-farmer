extends Control
@onready var player: CharacterBody2D = $"../../Player"
@onready var planet: Planet = $"../../Planet"
@onready var money_label: Label = $MarginContainer/Money
@onready var water_bar: TextureProgressBar = $Water
@onready var planet_health_bar: ProgressBar = $PlanetHealth

var money
var PLANT_MONEY = 5 # default amount of money harvested

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	money = 0
	money_label.text = str(money)
	water_bar.max_value = player.WATER_CAPACITY
	water_bar.min_value = 0.0
	water_bar.value = player.current_water
	planet_health_bar.max_value = planet.health_component.MAX_HEALTH
	planet_health_bar.min_value = 0.0
	planet_health_bar.value = planet.health_component.health

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
	SignalHub.plant_harvested.connect(on_plant_harvested) # TODO: make better
	SignalHub.water_shot.connect(on_water_changed)
	SignalHub.water_collected.connect(on_water_changed)
	SignalHub.planet_damaged.connect(on_planet_health_changed)

func on_water_changed() -> void:
	water_bar.value = player.current_water

func on_planet_health_changed() -> void:
	planet_health_bar.value = planet.health_component.health
