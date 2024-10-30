extends CharacterBody2D


@export var speed := 400.0
@export var spawn_variation := 45


var is_alive := false


func _process(_delta):
	if (Input.is_action_pressed("start") and not is_alive):
		_spawn()
		is_alive = true


func _physics_process(delta):
	# Try to detect collision during movement
	var collision_info = move_and_collide(velocity * delta)
	
	# Collision detected
	if collision_info:
		var colliding_object = collision_info.get_collider() as Node
		if colliding_object.is_in_group("tile"):
			(colliding_object as Tile).destroy()
		
		# Bounce
		velocity = velocity.bounce(collision_info.get_normal())


func _spawn():
	# Determine spawn position
	var spawn_x = randf_range(433, 933)
	global_position = Vector2(spawn_x, 600)

	# Determine initial movement angle
	var initial = deg_to_rad(-spawn_variation)
	var final = deg_to_rad(spawn_variation)
	var angle = randf_range(initial, final)

	# Determine movement direction
	velocity.y = -speed
	velocity = velocity.rotated(angle)

	# Enable visibility
	visible = true


# func clear():
# 	# Teleport outside of screen
# 	velocity = Vector2.ZERO
# 	global_position = Vector2(-50, -50)
