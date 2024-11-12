extends CharacterBody2D


@export var speed := 400.0
@export var speed_step := 100.0
@export var spawn_variation := 45


var _current_tier: int


func _ready():
	EventBus.on_respawn_requested.sub(_schedule_spawn)
	EventBus.on_game_restarted.sub(_reset)
	_schedule_spawn()


func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		_process_collision(collision_info)


func _process_collision(collision_info: KinematicCollision2D):
	var colliding_object = collision_info.get_collider() as Node
	if colliding_object.is_in_group("tile"):
		_score(colliding_object as Tile)
	if colliding_object.is_in_group("death"):
		_die()
	
	_bounce(collision_info)


func _score(tile: Tile):
	_change_velocity(tile)
	_destroy_tile(tile)


func _die():
	EventBus.on_ball_lost.trigger()
	_clear()


func _bounce(collision_info: KinematicCollision2D):
	velocity = velocity.bounce(collision_info.get_normal())


func _change_velocity(tile: Tile):
	if tile.tier > _current_tier:
		_current_tier = tile.tier
		if velocity.y < 0:
			velocity.y -= speed_step
		if velocity.y > 0:
			velocity.y += speed_step
		if velocity.x < 0:
			velocity.x -= speed_step
		if velocity.x > 0:
			velocity.x += speed_step


func _destroy_tile(tile: Tile):
	tile.destroy()


func _spawn():
	# Determine spawn position
	var spawn_x = randf_range(433, 933)
	global_position = Vector2(spawn_x, 600)

	# Determine initial movement angle
	var initial = deg_to_rad(-spawn_variation)
	var final = deg_to_rad(spawn_variation)
	var angle = randf_range(initial, final)

	# Determine movement direction
	velocity.y = -speed - (_current_tier * speed_step)
	velocity = velocity.rotated(angle)

	# Enable visibility
	visible = true


func _clear():
	velocity = Vector2.ZERO
	visible = false


func _schedule_spawn():
	get_tree().create_timer(Globals.RESPAWN_TIME).timeout.connect(_spawn)


func _reset():
	_current_tier = 0
	_schedule_spawn()