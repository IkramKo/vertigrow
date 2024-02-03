extends CharacterBody2D

# Time
#var start_time = OS.get_ticks_msec()

# Movement variables
var speed = 1600
var movement = Vector2(0, 0)
var direction = Vector2(-1, 0)
var sprite = get_child(0)
var dead_fish = load("res://assets/dead_fish.png") 

# Fish attributes
var health = 10
var waste_rate = 0
var age = 0
var reproduction_rate = 0

func _ready():
	init()
	#start_time = OS.get_ticks_msec()
	#pass
	
#func _process(delta):
	#var current_time = OS.get_ticks_msec()
	#var elapsed_time = (current_time - start_time) / 1000.0
	#print("Elapsed time in seconds: ", elapsed_time)
	
func init():
	sprite = get_child(0)
	
func flip_sprite():
	sprite.flip_h = !sprite.flip_h
	direction.x = -direction.x

func kill_fish():
	if health <= 0:	
		sprite.texture = dead_fish
		direction = Vector2(0, 1)
		sprite.flip_h = false
	 
func set_health(health):	
	health = health
	
func set_reproductive_rates(rate):
	reproduction_rate = rate

# Game loop	
func _physics_process(delta):
	movement = direction * speed * delta
	var collision = move_and_collide(movement * delta)
	
	if collision:
		flip_sprite()
