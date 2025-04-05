extends Node2D



func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		GameManager.load_main_scene()
	if event.is_action_pressed("reload"):
		get_tree().reload_current_scene()
		

func _ready() -> void:
	print("Level Loaded: ", GameManager.get_level_selected())
