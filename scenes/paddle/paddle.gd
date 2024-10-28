extends CharacterBody2D


@export var speed := 400.0
@export var initial_position := Vector2(0, 0)


func _ready():
	global_position = initial_position


func _process(_delta):
	velocity = Vector2.ZERO
	_process_movement()
	move_and_slide()


func _process_movement():
	if Input.is_action_pressed("left"):
		velocity.x = -1
	if Input.is_action_pressed("right"):
		velocity.x = 1

	velocity *= speed