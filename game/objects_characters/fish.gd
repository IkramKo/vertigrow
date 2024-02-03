extends CharacterBody2D

var speed = 1600
var movement = 0
var direction = Vector2(-1, 0)
var sprite = get_child(0)

func _ready():
	pass

func _physics_process(delta):
	sprite = get_child(0)
	movement = direction * speed * delta
	var collision = move_and_collide(movement * delta)
	
	if collision:
		sprite.flip_h = !sprite.flip_h
		direction.x = -direction.x

	#movement.y += sin(global_position.x / 100.0) * 10.0
	#velocity = movement
#
	## Get the largest CollisionShape2D of the parent
	#var largest_shape = null
	#var max_length = 0
	#for child_node in get_parent().get_children():
		#for child in child_node.get_children():
			#if child is CollisionShape2D:
				#var length = 0
				#if child.shape is SegmentShape2D:
					#length = child.shape.b.distance_to(child.shape.a)
				#else:
					#length = child.shape.extents.length() * 2
				#if length > max_length:
					#max_length = length
					#largest_shape = child
				#print(largest_shape)
	#
	## Check if the character has hit the edge of the largest shape
	#if largest_shape != null and global_position.distance_to(Vector2(0, 0)) > largest_shape.shape.extents.length() * 2:
		#direction = direction * Vector2(-1, 1)
	
	#move_and_collide(direction)
