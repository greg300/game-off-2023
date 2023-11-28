extends CharacterBody2D

const SPEED = 100.0
const ACCELERATION = 800.0
const FRICTION = 2000.0
const JUMP_VELOCITY = -300.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()

	var input_axis = Input.get_axis("player_left", "player_right")
	handle_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)
	
	move_and_slide()
	
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
