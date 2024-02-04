extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_total_waste_rate():
	var num_fishes = get_child_count() - 1
	var waste_rate = get_child(1).waste_rate
	return num_fishes * waste_rate

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
