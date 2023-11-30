extends CharacterBody2D

const SPEED = 100.0
const ACCELERATION = 800.0
const FRICTION = 2000.0
const JUMP_VELOCITY = -300.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var scale_lvl = 0


func _physics_process(delta):
	scale = Level.calc_scale_vec(scale_lvl)
	
	apply_gravity(delta)
	handle_jump()

	var input_axis = Input.get_axis("player_left", "player_right")
	handle_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)
	
	var collided = move_and_slide()
	if collided:
		var level: Level = get_node("/root/Level")
		level.last_collisions.clear()
		for i in range(get_slide_collision_count()):
			level.last_collisions.append(get_slide_collision(i))
	
func apply_gravity(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
func handle_jump():
	# Handle Jump.
	if is_on_floor():
		if Input.is_action_just_pressed("player_jump"):
			velocity.y = JUMP_VELOCITY
	else:
		# Allow player to perform small jumps by releasing JUMP button early.
		if Input.is_action_just_released("player_jump") and velocity.y < JUMP_VELOCITY / 2:
			velocity.y = JUMP_VELOCITY / 2

func handle_acceleration(input_axis, delta):
	# Handle acceleration.
	if input_axis:
		velocity.x = move_toward(velocity.x, SPEED * input_axis, ACCELERATION * delta)

func apply_friction(input_axis, delta):
	# Handle deceleration.
	if not input_axis:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)

func scale_up_or_down(scale_dir: Level.ScaleDir) -> void:
	match scale_dir:
		Level.ScaleDir.UP:
			scale_lvl += 1
		Level.ScaleDir.DOWN:
			scale_lvl -= 1
