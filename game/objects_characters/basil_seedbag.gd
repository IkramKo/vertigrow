extends Node2D

const BASIL_ROW_SCENE = "res://objects_characters/plants/basil_row.tscn"
var basil_scene = preload(BASIL_ROW_SCENE)

# Hierarchy
var shelf = Node
var farm = Node
var growbed = Node

# Called when the node enters the scene tree for the first time.
func _ready():
	self.shelf = get_parent()
	self.farm = shelf.get_parent()
	self.growbed = farm.get_child(3)
	
	
	if self.basil_scene == null:
		print("Failed to load scene at path: ", BASIL_ROW_SCENE)
		return

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# making sure were clickin on sprite
		if self.get_child(0).get_child(0).get_rect().has_point(to_local(event.position)):
			load_basil_row()

func load_basil_row():
	if !self.growbed.get_basil_row():

		var new_basil_row = basil_scene.instantiate()
		new_basil_row.name = "basil_row"
		new_basil_row.position = Vector2(453, 387)
		self.growbed.add_child(new_basil_row)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
