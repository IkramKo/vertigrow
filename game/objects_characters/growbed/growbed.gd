extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_tomato_row():
	var children = self.get_children()
	var tomato_row = Node2D.new()
	
	for child in children:
		if "tomato_row" in child.get_name().to_lower():
			tomato_row = child
	return tomato_row
	
func get_basil_row():
	var children = self.get_children()
	var basil_row = Node2D.new()
	
	for child in children:
		if "basil_row" in child.get_name().to_lower():
			basil_row = child
	return basil_row
	
func get_kale_row():
	var children = self.get_children()
	var kale_row = Node2D.new()
	
	for child in children:
		if "kale_row" in child.get_name().to_lower():
			kale_row = child
	return kale_row
	
func get_plants():
	var plants = []
	var tomato_row = self.get_tomato_row()
	var basil_row = self.get_basil_row()
	var kale_row = self.get_kale_row()
	
	if tomato_row.has_method("set_health"):
		plants.append(tomato_row)
	if basil_row.has_method("set_health"):
		plants.append(basil_row)
	if kale_row.has_method("set_health"):
		plants.append(kale_row)
	return plants
	
#func increase_age():
	
