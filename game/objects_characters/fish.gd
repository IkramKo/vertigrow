extends CharacterBody2D

# Time
#var start_time = OS.get_ticks_msec()

# Movement variables
var speed = 1600
var movement = Vector2(0, 0)
var direction = Vector2(-1, 0)
var vertical_offset = randf_range(-2, 2) * 0.5
var fish_collision_active = false
var sprite = get_child(0)
var dead_fish = load("res://assets/dead_fish.png") 

# Fish attributes
var health = 5
var waste_rate = 5
var age = 0
var reproduction_rate = 0
var id = 0

func _ready():
	init()
	set_collision_layers()
	#start_time = OS.get_ticks_msec()
	#pass
	
func set_collision_layers():
	self.set_collision_layer_value(2, true) # fish in layer 2
	self.set_collision_mask_value(1, true)   # only allowing collisions with layer 1 (tank)
	#self.set_collision_mask_value(2, false)  # excluding collisions with layer 2 (other fish)
	
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
	self.health = health
	
func set_reproductive_rates(rate):
	self.reproduction_rate = rate

func increase_age():
	self.age += 1

# Game loop	
#func _physics_process(delta):
	#movement = direction * speed * delta
	#var collision = move_and_collide(movement * delta)
	#if collision:
		#var collider = collision.get_collider()
	#
		#if collider.is_in_group("Tank"):
			#self.set_collision_mask_value(2, true)
			#flip_sprite()
		##elif collider.is_in_group("Fish"):
			##self.set_collision_mask_value(2, false)
			##pass
func _physics_process(delta):
	movement = direction * speed * delta
	self.velocity = movement
	move_and_slide()

	fish_collision_active = false

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)

		if collision.get_collider().is_in_group("Tank"):
			flip_sprite()
		elif collision.get_collider().is_in_group("Fish"):
			fish_collision_active = true
			direction.y = self.vertical_offset

	if !fish_collision_active:
		direction.y = 0


		#print("Collided with: ", collision.get_collider().name)


	#var colliders = get_slide_collision()
	#get_slide_collision()
	#for collider in colliders:
		#if collider.is_in_group("Tank"):
			#flip_sprite()
