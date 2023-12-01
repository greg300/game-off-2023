extends CharacterBody2D

const SPEED = 100.0
const ACCELERATION = 800.0
const FRICTION = 2000.0
const JUMP_VELOCITY = -300.0
const JUMP_ZOOM_EFFECT = 100.0
const TIME_TO_ZOOM: float = 0.15 # note: this must be identical to Background.TIME_TO_ZOOM
const BACKGROUND_ZOOM_INTERVAL = 0.1 # note: this must be identical to Level.TIME_TO_ZOOM

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player_zoom = 1.0
var target_zoom: float = player_zoom
var facing_direction: int = 0


func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()

	var input_axis: float = Input.get_axis("player_left", "player_right")
	face_direction(input_axis)
	handle_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)
	
	move_and_slide()
	
func apply_gravity(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
func handle_jump():
	# Handle Jump.
	var jump_power = (JUMP_VELOCITY + JUMP_ZOOM_EFFECT * (1 - player_zoom))
	if is_on_floor():
		if Input.is_action_just_pressed("player_jump"):
			velocity.y = jump_power
	else:
		# Allow player to perform small jumps by releasing JUMP button early.
		if Input.is_action_just_released("player_jump") and velocity.y < jump_power / 2:
			velocity.y = jump_power / 2

func handle_acceleration(input_axis, delta):
	# Handle acceleration.
	if input_axis:
		velocity.x = move_toward(velocity.x, SPEED * input_axis, ACCELERATION * delta)

func apply_friction(input_axis, delta):
	# Handle deceleration.
	if not input_axis:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)

func face_direction(last_accel: float) -> void:
	var facing_left: bool
	if velocity.x < 0:
		facing_left = true
	elif velocity.x > 0:
		facing_left = false
	elif last_accel < 0:
		facing_left = true
	elif last_accel > 0:
		facing_left = false
	elif facing_direction < 0:
		facing_left = true
	else:
		facing_left = false
	
	facing_direction = int(facing_left) * -2 + 1
	$Sprite2D.flip_h = facing_left

# func _process(delta: float) -> void:
# 	if player_zoom != target_zoom:
# 		var partway: float = delta / TIME_TO_ZOOM
# 		if partway < 1:
# 			player_zoom += partway * BACKGROUND_ZOOM_INTERVAL * (target_zoom - player_zoom)
# 		else:
# 			player_zoom = target_zoom
# 		scale = Vector2(player_zoom, player_zoom)
