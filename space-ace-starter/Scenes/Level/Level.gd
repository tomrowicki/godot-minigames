extends Node2D


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("test"):
		SignalHub.emit_on_create_explosion(Vector2(30, 30), "boom")
