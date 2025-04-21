extends Node2D


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("test"):
		#SignalHub.emit_on_create_explosion(Vector2(30, 30), "boom")
		#SignalHub.emit_on_powerup_init(Vector2(50, 50), PowerUp.PowerUpType.Health)
		#SignalHub.emit_on_powerup_init(Vector2(70, 70), PowerUp.PowerUpType.Shield)
		SignalHub.emit_on_random_powerup_init(Vector2(80, 80))
