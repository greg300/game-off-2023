extends Node2D

const BACKGROUND_SPEED = 50.0
const BACKGROUND_ZOOM_MAX = 1.5
const BACKGROUND_ZOOM_MIN = 0.5
const BACKGROUND_ZOOM_INTERVAL = 0.1
var background_zoom = 1.0

@onready var background = $Background
@onready var player = $Player
@onready var goal = $Goal


func _ready():
	pass

func _physics_process(_delta):
#	var input_direction = Input.get_vector("bg_left", "bg_right", "bg_up", "bg_down")
#
#	background.velocity = input_direction * BACKGROUND_SPEED

	if Input.is_action_just_pressed("reset_level"):
		reset_level()
	
	if Input.is_action_just_pressed("bg_scale_down"):
		if background_zoom > BACKGROUND_ZOOM_MIN:
			background_zoom -= BACKGROUND_ZOOM_INTERVAL
			scale_platforms(Vector2(background_zoom, background_zoom))
			scale_player('d')
	if Input.is_action_just_pressed("bg_scale_up"):
		if background_zoom < BACKGROUND_ZOOM_MAX:
			background_zoom += BACKGROUND_ZOOM_INTERVAL
			scale_platforms(Vector2(background_zoom, background_zoom))
			scale_player('u')
			
	if goal.get_node("Area").overlaps_body(player):
		print("Reached goal....")
		transition_level()
		
	
#	background.move_and_slide()
	
func scale_platforms(new_scale):
	background.scale = new_scale
#	for platform in background.platforms.get_children():
#		platform.apply_scale(scale)
		
func scale_player(direction):
	for platform in background.get_node("Platforms").get_children():
		if platform.get_node("Area2D").overlaps_body(player):
			print("Scaling player....")
			var new_player_zoom = player.player_zoom
			#if player.player_zoom < background_zoom and direction == 'u':
			if direction == 'u' and player.player_zoom < BACKGROUND_ZOOM_MAX:
				new_player_zoom += BACKGROUND_ZOOM_INTERVAL
			if direction == 'd' and player.player_zoom > BACKGROUND_ZOOM_MIN:
			#if player.player_zoom > background_zoom and direction == 'd':
				new_player_zoom -= BACKGROUND_ZOOM_INTERVAL
			player.scale = Vector2(new_player_zoom, new_player_zoom)
			player.player_zoom = new_player_zoom

			break

func reset_level():
	get_tree().change_scene_to_file(goal.LEVELS[GlobalData.current_level])

func transition_level():
	var next_level = GlobalData.current_level + 1
	if next_level == goal.LEVEL_END:
		return
		#get_tree().change_scene_to_file(END)
		
	print("Switching to level " + str(next_level + 1))
	GlobalData.current_level = next_level
	get_tree().change_scene_to_file(goal.LEVELS[next_level])
		
