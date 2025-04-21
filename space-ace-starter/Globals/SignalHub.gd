extends Node


signal on_player_hit(v: int)
signal on_score_updated(v: int)
signal on_create_explosion(pos: Vector2, animation_name: String)
signal on_powerup_init(pos: Vector2, type: PowerUp.PowerUpType)
signal on_random_powerup_init(pos: Vector2)


func emit_on_player_hit(v: int) -> void:
	on_player_hit.emit(v)


func emit_on_score_updated(v: int):
	on_score_updated.emit(v)
	
	
func emit_on_create_explosion(pos: Vector2, animation_name: String) -> void:
		on_create_explosion.emit(pos, animation_name)
		
		
func emit_on_powerup_init(pos: Vector2, type: PowerUp.PowerUpType) -> void:
	on_powerup_init.emit(pos, type)
	
	
func emit_on_random_powerup_init(pos: Vector2) -> void:
	var rand = randi_range(0, 1)
	var type: PowerUp.PowerUpType = PowerUp.PowerUpType.values().get(rand)
	# OR use PowerUp.PowerUpType.values().pick_random()
	on_powerup_init.emit(pos, type)
