extends CharacterBody2D

const SPEED = 50.0

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
