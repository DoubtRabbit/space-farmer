extends Plant
var active: bool = false

func water() -> void:
	if (grow_component.is_ready()):
		active = true
	else:
		grow_component.water()

# rn doesnt get used!!!!!
func harvest_plant() -> void: #TODO: can turn this into a component
	queue_free()
	SignalHub.plant_harvested.emit()
