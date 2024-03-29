extends Node2D

# timer vcars
var age_timer = Timer.new()
var age_increment_interval = 10

var health_timer = Timer.new()
var health_change_interval = 10

var farm_stat_timer = Timer.new()
var farm_stat_interval = 1

var fish_tank = get_child(1)
var shelves = get_child(2)
var growbed = get_child(3)

var curr_water_quality = 7

var stats_panel = get_child(4)

# Called when the node enters the scene tree for the first time.
func _ready():
	init()
	
func init():
	self.fish_tank = get_child(1)
	self.shelves = get_child(2)
	self.growbed = get_child(3)
	self.stats_panel = get_child(4)
	setup_age_timer()
	setup_health_timer()
	setup_stat_timer()

func setup_age_timer():
	age_timer.set_wait_time(age_increment_interval)
	age_timer.set_one_shot(false)
	age_timer.connect("timeout", _on_age_timer_timeout)
	add_child(age_timer)
	age_timer.start()

func _on_age_timer_timeout():
	#_increase_plant_age()
	_increase_fish_age()

func setup_health_timer():
	self.health_timer.set_wait_time(health_change_interval)
	self.health_timer.set_one_shot(false)
	self.health_timer.connect("timeout", asses_farm_stability)
	add_child(self.health_timer)
	self.health_timer.start()

func setup_stat_timer():
	self.farm_stat_timer.set_wait_time(farm_stat_interval)
	self.farm_stat_timer.set_one_shot(false)
	self.farm_stat_timer.connect("timeout", check_farm_stats)
	add_child(self.farm_stat_timer)
	self.farm_stat_timer.start()

func _increase_plant_age():
	var children = growbed.get_plants()
	for plant in children:
		plant.increase_age()

func _increase_fish_age():
	var children = fish_tank.get_all_fish()
	for fish in children:
		fish.increase_age()

func check_farm_stats():
	
	var tomato_row = self.growbed.get_tomato_row()
	var kale_row = self.growbed.get_kale_row()
	var basil_row = self.growbed.get_basil_row()
	
	# Total waste rate
	var total_waste_rate = self.fish_tank.get_total_waste_rate()

	# Total filering rate
	var tomato_row_f_rate = 0
	var kale_row_f_rate = 0 
	var basil_row_f_rate = 0
	
	if kale_row.name == "kale_row" and kale_row.has_method("get_health"):
		kale_row_f_rate = kale_row.get_filtering_rate()
		print("HELLO KALE")
	if tomato_row.name == "kale_row" and tomato_row.has_method("get_health"):
		tomato_row_f_rate = tomato_row.get_filtering_rate()
		print("HELLO TOMATO")
	if basil_row.name == "basil_row" and basil_row.has_method("get_health"):
		basil_row_f_rate = kale_row.get_filtering_rate()
		print("HELLO BASIL")
	
	var total_filtering_rate = tomato_row_f_rate + kale_row_f_rate + basil_row_f_rate
	# If < 0: we have too many plants -> not enough nutrients for each plant = --health for plants
	# If > 0: we have too many fishes -> water quality goes down = --health for fishes and plants
	# else: perfect
	var result = total_waste_rate - total_filtering_rate
	var new_water_qual = self.curr_water_quality
	if result > 0:
		new_water_qual = max(new_water_qual - log(result), 0)
	elif result < 0 and kale_row.has_method("set_health") and tomato_row.has_method("set_health") and basil_row.has_method("set_health"): # Not enough nutrients for plants
		new_water_qual = min(new_water_qual + log(-result), 8)
	
	self.curr_water_quality = new_water_qual
	self.stats_panel.get_child(0).text = str(round(self.curr_water_quality * 100)/100)
	self.stats_panel.get_child(3).text = str(round(total_waste_rate * 100)/100)
	self.stats_panel.get_child(4).text = str(round(total_filtering_rate * 100)/100)


func asses_farm_stability():
	
	var tomato_row = self.growbed.get_tomato_row()
	var kale_row = self.growbed.get_kale_row()
	var basil_row = self.growbed.get_basil_row()
	
	# Total waste rate
	var total_waste_rate = self.fish_tank.get_total_waste_rate()

	# Total filering rate
	var tomato_row_f_rate = 0
	var kale_row_f_rate = 0 
	var basil_row_f_rate = 0
	
	if kale_row.name == "kale_row" and kale_row.has_method("get_health"):
		kale_row_f_rate = kale_row.get_filtering_rate()
		print("HELLO KALE")
	if tomato_row.name == "kale_row" and tomato_row.has_method("get_health"):
		tomato_row_f_rate = tomato_row.get_filtering_rate()
		print("HELLO TOMATO")
	if basil_row.name == "basil_row" and basil_row.has_method("get_health"):
		basil_row_f_rate = kale_row.get_filtering_rate()
		print("HELLO BASIL")
	
	var total_filtering_rate = tomato_row_f_rate + kale_row_f_rate + basil_row_f_rate
	# If < 0: we have too many plants -> not enough nutrients for each plant = --health for plants
	# If > 0: we have too many fishes -> water quality goes down = --health for fishes and plants
	# else: perfect
	var result = total_waste_rate - total_filtering_rate
	var new_water_qual = self.curr_water_quality
	if result > 0:
		new_water_qual = max(new_water_qual - log(result), 0)
	elif result < 0 and kale_row.has_method("set_health") and tomato_row.has_method("set_health") and basil_row.has_method("set_health"): # Not enough nutrients for plants
		tomato_row.set_health(tomato_row.get_health() - 1)
		kale_row.set_health(tomato_row.get_health() - 1)
		basil_row.set_health(basil_row.get_health() - 1)
		new_water_qual = min(new_water_qual + log(-result), 8)
	
	self.curr_water_quality = new_water_qual
	
	if self.curr_water_quality <= 6.5 or self.curr_water_quality >= 7.5:
		if tomato_row.has_method("set_health"):
			tomato_row.set_health(tomato_row.get_health() - 1)
		if kale_row.has_method("set_health"):
			kale_row.set_health(tomato_row.get_health() - 1)
		if basil_row.has_method("set_health"):
			basil_row.set_health(basil_row.get_health() - 1)
		self.fish_tank.reduce_tank_health()
	
	# Reproduce fish
	self.shelves.get_child(6).load_fish()
	
	#print("Water quality: ", self.curr_water_quality)
	#print("Waste rate:", total_waste_rate)
	#print("Filter rate:", total_filtering_rate)
	self.stats_panel.get_child(0).text = str(round(self.curr_water_quality * 100)/100)
	self.stats_panel.get_child(3).text = str(round(total_waste_rate * 100)/100)
	self.stats_panel.get_child(4).text = str(round(total_filtering_rate * 100)/100)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

