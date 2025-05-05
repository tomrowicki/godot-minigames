extends Control


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("level"):
		GameManager.load_level_scene()
	elif Input.is_action_just_pressed("main"):
		GameManager.load_main_scene()
