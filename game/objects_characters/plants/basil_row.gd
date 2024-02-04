extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_num_plants_alive():
	var result = 0
	var plants = get_children()
	for plant in plants:
		if plant.get_health() > 0:
			result += 1
	return result
	
func get_filering_rate():
	var num_plants_alive = get_num_plants_alive()
	var filering_rate = get_child(0).filering_rate
	return num_plants_alive * filering_rate

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
