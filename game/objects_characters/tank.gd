extends Node2D

# Bounds
const RIGHT_BOUND_X = 125
const LEFT_BOUND_X = 75
const TOP_BOUND_Y = 65
const BOTTOM_BOUND_Y = 225

# Called when the node enters the scene tree for the first time.
func _ready():
	set_collision_layers()
	#start_time = OS.get_ticks_msec()
	#pass
func set_collision_layers():
	self.get_child(0).set_collision_layer_value(1, true) # tank in layer 1
	self.get_child(0).set_collision_mask_value(2, true)  # allow collision with fish in layer 2


func get_total_waste_rate():
	var num_fishes = get_child_count() - 1
	if num_fishes == 0:
		return 0
	var waste_rate = get_child(1).waste_rate
	return num_fishes * waste_rate

func reduce_tank_health():
	var num_fishes = get_child_count() - 1 # How many points we will have to dock
	var fishes = get_children() # Only from index 1
	
	var health_to_reduce = num_fishes
	
	print("Health to reduce: ", health_to_reduce)
	print("Num fish: ", num_fishes)
	# 0 | (1 2)
	for idx in range(num_fishes, 1, -1):
		var fish_health = fishes[idx].health
		var health_to_remove = min(fish_health, health_to_reduce)
		fishes[idx].set_health(fish_health - health_to_remove)
		fishes[idx].kill_fish()
		health_to_reduce -= health_to_remove
		
		if health_to_reduce <= 0:
			break
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func get_x_bounds():
	return Vector2(LEFT_BOUND_X, RIGHT_BOUND_X)

func get_y_bounds():
	return Vector2(TOP_BOUND_Y, BOTTOM_BOUND_Y)
	
func get_all_fish():
	var children = self.get_children()
	var fish = []
	for child in children:
		if "characterbody" in child.get_name().to_lower() or "fish" in child.get_name().to_lower():
			fish.append(child)
	return fish
