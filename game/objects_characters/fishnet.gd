extends Node2D

# Hierarchy
var shelf = Node
var farm = Node
var tank = Node

func _ready():
	self.shelf = get_parent()
	self.farm = shelf.get_parent()
	self.tank = farm.get_child(1)

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# making sure were clickin on sprite
		if self.get_child(0).get_child(0).get_rect().has_point(to_local(event.position)):
			remove_oldest_fish()

func remove_oldest_fish():
	var children = tank.get_all_fish()
	print(len(children))
	if len(children) > 0:
		var oldest_fish = children[0]
		for fish in children:
			if fish.age > oldest_fish.age or fish.health <= 0:
				oldest_fish = fish
		tank.remove_child(oldest_fish)		
	#tank.remove_child(children[0])
