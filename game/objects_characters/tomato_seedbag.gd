extends Node2D

const TOMATO_ROW_SCENE = "res://objects_characters/plants/tomato_row.tscn"
var tomato_scene = preload(TOMATO_ROW_SCENE)

# Hierarchy
var shelf = Node
var farm = Node
var growbed = Node

# Called when the node enters the scene tree for the first time.
func _ready():
	self.shelf = get_parent()
	self.farm = shelf.get_parent()
	self.growbed = farm.get_child(3)
	
	
	if self.tomato_scene == null:
		print("Failed to load scene at path: ", TOMATO_ROW_SCENE)
		return

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# making sure were clickin on sprite
		if self.get_child(0).get_child(0).get_rect().has_point(to_local(event.position)):
			load_tomato_row()

func load_tomato_row():
	if !self.growbed.get_tomato_row().has_method("set_health"):
		var new_tomato_row = tomato_scene.instantiate()
		new_tomato_row.name = "tomato_row"
		new_tomato_row.position = Vector2(445, 485)
		self.growbed.add_child(new_tomato_row)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
