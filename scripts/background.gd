extends CharacterBody2D

const SPEED = 50.0
const TIME_TO_ZOOM: float = 0.15
var target_scale: Vector2 = scale

@onready var platforms = $Platforms


func _ready():
	pass

#func _physics_process(delta):
#	var input_direction = Input.get_vector("bg_left", "bg_right", "bg_up", "bg_down")
#
#	velocity = input_direction * SPEED
#
#	if Input.is_action_just_pressed("bg_scale_down"):
#		scale_platforms(Vector2(0.9, 0.9))
#	if Input.is_action_just_pressed("bg_scale_up"):
#		scale_platforms(Vector2(1.1, 1.1))
#
#	move_and_slide()
#
#func scale_platforms(scale):
#	for platform in platforms.get_children():
#		platform.apply_scale(scale)

func _process(delta: float) -> void:
	if scale != target_scale:
		var partway: float = delta / TIME_TO_ZOOM
		if partway < 1:
			scale += (delta / TIME_TO_ZOOM) * (target_scale - scale)
		else:
			scale = target_scale
