extends Node2D

const FISH_SCENE_PATH = "res://objects_characters/fish.tscn"
var fish_scene = preload(FISH_SCENE_PATH)

# Hierarchy
var shelf = Node
var farm = Node
var tank = Node

# Bounds
const RIGHT_BOUND_X = 125
const LEFT_BOUND_X = 75
const TOP_BOUND_Y = 65
const BOTTOM_BOUND_Y = 225

func _ready():
	self.shelf = get_parent()
	self.farm = shelf.get_parent()
	self.tank = farm.get_child(1)
	
	if self.fish_scene == null:
		print("Failed to load scene at path: ", FISH_SCENE_PATH)
		return

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		load_fish()

func load_fish():
	# Instantiate the new fish scene
	var new_fish = self.fish_scene.instantiate()
	
	# Set the position of the new instance to a random position within bounds
	new_fish.position = Vector2(randf_range(LEFT_BOUND_X, RIGHT_BOUND_X), randf_range(TOP_BOUND_Y, BOTTOM_BOUND_Y))
	
	# Add the new instance to the current scene
	#add_child(new_fish)
	
	# Get shelf
	var shelf = get_parent()
	var farm = shelf.get_parent()
	var tank = farm.get_child(1)
	tank.add_child(new_fish)
