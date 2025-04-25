extends Control

@onready var health_bar: HealthBar = $ColorRect/MC/HealthBar
@onready var sound: AudioStreamPlayer = $Sound

# Called when the node enters the scene tree for the first time.
func _enter_tree() -> void:
	SignalHub.on_player_hit.connect(on_player_hit)
	SignalHub.on_player_health_bonus.connect(on_player_health_bonus)

func on_player_hit(v: int) -> void:
	health_bar.take_damage(v)
	

func _on_health_bar_died() -> void:
	print("Player died")


func on_player_health_bonus(v: int) -> void:
	health_bar.incr_value(v)
	sound.play()
