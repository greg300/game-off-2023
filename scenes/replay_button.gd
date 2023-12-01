extends Button


func _pressed():
	GlobalData.current_level = 0
	get_tree().change_scene_to_file("res://scenes/level1.tscn")
