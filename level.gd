extends Node2D

const BACKGROUND_SPEED = 50.0
const BACKGROUND_ZOOM_MAX = 1.5
const BACKGROUND_ZOOM_MIN = 0.5
const BACKGROUND_ZOOM_INTERVAL = 0.1
var background_zoom = 1.0

@onready var background = $Background
@onready var player = $Player


func _ready():
	pass

func _physics_process(delta):
#	var input_direction = Input.get_vector("bg_left", "bg_right", "bg_up", "bg_down")
#
#	background.velocity = input_direction * BACKGROUND_SPEED
	
	if Input.is_action_just_pressed("bg_scale_down"):
		if background_zoom > BACKGROUND_ZOOM_MIN:
			background_zoom -= BACKGROUND_ZOOM_INTERVAL
			scale_platforms(Vector2(background_zoom, background_zoom))
			scale_player(Vector2(background_zoom, background_zoom))
	if Input.is_action_just_pressed("bg_scale_up"):
		if background_zoom < BACKGROUND_ZOOM_MAX:
			background_zoom += BACKGROUND_ZOOM_INTERVAL
			scale_platforms(Vector2(background_zoom, background_zoom))
			scale_player(Vector2(background_zoom, background_zoom))
	
#	background.move_and_slide()
	
func scale_platforms(newScale):
	background.scale = newScale
#	for platform in background.platforms.get_children():
#		platform.apply_scale(newScale)
		
func scale_player(newScale):
	for platform in background.get_node("Platforms").get_children():
		if platform.get_node("Area2D").overlaps_body(player):
			print("Scaling player....")
			player.scale = newScale
			break
