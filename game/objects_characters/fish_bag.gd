extends Node2D

const FISH_SCENE_PATH = "res://objects_characters/fish.tscn"
var fish_scene = preload(FISH_SCENE_PATH)

# Hierarchy
var shelf = Node
var farm = Node
var tank = Node

func _ready():
	self.shelf = get_parent()
	self.farm = shelf.get_parent()
	self.tank = farm.get_child(1)
	
	if self.fish_scene == null:
		print("Failed to load scene at path: ", FISH_SCENE_PATH)
		return

#func _input(event):
	#if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		#if is_mouse_within_bounds():
			#load_fish()

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# making sure were clickin on sprite
		if self.get_child(0).get_child(0).get_rect().has_point(to_local(event.position)):
			load_fish()

func load_fish():
	var new_fish = fish_scene.instantiate()
	new_fish.position = Vector2(randf_range(tank.get_x_bounds().x, tank.get_x_bounds().y), randf_range(tank.get_y_bounds().x, tank.get_y_bounds().y))
	tank.add_child(new_fish)
