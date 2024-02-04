extends Node2D

# Hierarchy
var shelf = Node
var farm = Node
var growbed = Node

func _ready():
	self.shelf = get_parent()
	self.farm = shelf.get_parent()
	self.growbed = farm.get_child(3)

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# making sure were clickin on sprite
		if self.get_child(0).get_child(0).get_rect().has_point(to_local(event.position)):
			remove_oldest_plant()

func remove_oldest_plant():
	var plants = []
	var tomato_row = growbed.get_tomato_row()
	var basil_row = growbed.get_basil_row()
	var kale_row = growbed.get_kale_row()
	
	if "tomato_row" in tomato_row.name:
		plants.append(tomato_row)
	if "basil_row" in basil_row.name:
		plants.append(basil_row)
	if "kale_row" in kale_row.name:
		plants.append(kale_row)
	#print(len(plants))
	if len(plants) > 0:
		#var oldest_plant = plants[0]
		#for plant in plants:
			#if plant.age > oldest_plant.age or plant.health <= 0:
				#oldest_plant = plant
		growbed.remove_child(plants[0])	
			
	#tank.remove_child(children[0])
