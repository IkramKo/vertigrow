extends Node2D

const KALE_ROW_SCENE = "res://objects_characters/plants/kale_row.tscn"
var kale_scene = preload(KALE_ROW_SCENE)

# Hierarchy
var shelf = Node
var farm = Node
var growbed = Node

# Called when the node enters the scene tree for the first time.
func _ready():
	self.shelf = get_parent()
	self.farm = shelf.get_parent()
	self.growbed = farm.get_child(3)
	
	
	if self.kale_scene == null:
		print("Failed to load scene at path: ", KALE_ROW_SCENE)
		return

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# making sure were clickin on sprite
		if self.get_child(0).get_child(0).get_rect().has_point(to_local(event.position)):
			load_kale_row()

func load_kale_row():
	if !self.growbed.get_kale_row().has_method("set_health"):
		var new_kale_row = kale_scene.instantiate()
		new_kale_row.name = "kale_row"
		new_kale_row.position = Vector2(455, 220)
		self.growbed.add_child(new_kale_row)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
