extends Node2D

class_name Pipes

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Moving pipes left
	position.x -= delta * 120.0
	check_off_screen()

func check_off_screen() -> void:
	if position.x < -500.0:
		queue_free()

# Does not fire when the scene is not being rendered (e. g. the window is minimised)
func _on_screen_exited() -> void:
	queue_free()
