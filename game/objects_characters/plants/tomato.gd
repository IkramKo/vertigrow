extends Node2D

var health = 10
var dead_tomato = load("res://assets/dead_tomato.png")
var sprite = get_child(0)

# Called when the node enters the scene tree for the first time.
func _ready():
	init()

func init():
	self.sprite = get_child(0).get_child(0)

func kill_tomato():
	if health <= 0:
		self.sprite.texture = dead_tomato

func set_health(health):	
	self.health = health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
