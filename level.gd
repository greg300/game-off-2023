extends Node2D
class_name Level

enum ScaleDir {UP, DOWN}

const BACKGROUND_SPEED = 50.0
const BG_ZOOM_MIN: int = -5
const BG_ZOOM_MAX: int = +5
const SCALE_FACTOR: float = 0.9
var bg_zoom_lvl: int = 0
var last_collisions: Array[KinematicCollision2D] = []

@onready var background = $Background
@onready var player = $Player

static func calc_scale_vec(scale_lvl: int) -> Vector2:
	var scale_factor: float = SCALE_FACTOR ** scale_lvl
	return Vector2(scale_factor, scale_factor)

func _ready():
	pass

func _physics_process(_delta):
#	var input_direction = Input.get_vector("bg_left", "bg_right", "bg_up", "bg_down")
#
#	background.velocity = input_direction * BACKGROUND_SPEED
	
	if Input.is_action_just_pressed("bg_scale_down"):
		if bg_zoom_lvl > BG_ZOOM_MIN:
			bg_zoom_lvl -= 1
			scale_bg(ScaleDir.DOWN, Level.calc_scale_vec(bg_zoom_lvl))
	if Input.is_action_just_pressed("bg_scale_up"):
		if bg_zoom_lvl < BG_ZOOM_MAX:
			bg_zoom_lvl += 1
			scale_bg(ScaleDir.UP, Level.calc_scale_vec(bg_zoom_lvl))
	
#	background.move_and_slide()
	
func scale_bg(scale_dir: ScaleDir, new_scale: Vector2) -> void:
	background.scale = new_scale
	var fucking_dumb_stupid_dumb_condition_variable: bool = false
	for any_bg_plat in $Background.platforms.get_children():
		if fucking_dumb_stupid_dumb_condition_variable == true:
			break
		for collision in last_collisions:
			if fucking_dumb_stupid_dumb_condition_variable == true:
				break
			var collider: Object = collision.get_collider()
			if any_bg_plat.is_ancestor_of(collider):
				player.scale_up_or_down(scale_dir)
				fucking_dumb_stupid_dumb_condition_variable = true
