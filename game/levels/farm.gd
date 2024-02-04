extends Node2D

var fish_tank = get_child(1)
var shelves = get_child(2)
var growbed = get_child(3)

var curr_water_quality = 7

# Called when the node enters the scene tree for the first time.
func _ready():
	init()
	
func init():
	self.fish_tank = get_child(1)
	self.shelves = get_child(2)
	self.growbed = get_child(3)
	calc_water_quality()

func calc_water_quality():

	#var children = growbed.get_children()
	var tomato_row = self.growbed.get_child(4)
	var kale_row = self.growbed.get_child(5)
	var basil_row = self.growbed.get_child(6)
	
	# Total waste rate
	var total_waste_rate = self.fish_tank.get_total_waste_rate()

	# Total filering rate
	var tomato_row_f_rate = tomato_row.get_filering_rate() 
	var kale_row_f_rate = kale_row.get_filtering_rate() 
	var basil_row_f_rate = basil_row.get_filtering_rate()
	
	var total_filtering_rate = tomato_row_f_rate + kale_row_f_rate + basil_row_f_rate
	# If < 0: we have too many plants -> not enough nutrients for each plant = --health for plants
	# If > 0: we have too many fishes -> water quality goes down = --health for fishes and plants
	# else: perfect
	var result = total_waste_rate - total_filtering_rate
	
	var new_water_qual = self.curr_water_quality
	if result > 0:
		new_water_qual -= log(result)
	
	print("New Water quality: ", new_water_qual)
	
	return new_water_qual
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
