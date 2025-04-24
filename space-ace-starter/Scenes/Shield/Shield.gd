extends Area2D


class_name Shield


@export var start_health: int = 5


@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sound: AudioStreamPlayer2D = $Sound


var _health: int = start_health


func _ready() -> void:
	disable_shield()


func disable_shield() -> void:
	timer.stop()
	hide()
	# disable collisions
	SpaceUtils.toggle_area2d(self, false)
	
	
func enable_shield() -> void:
	_health = start_health
	# reset the animation
	animation_player.play("RESET")
	# enable collisions
	SpaceUtils.toggle_area2d(self, true)
	timer.start()
	sound.play()
	show()
	
func hit() -> void:
	animation_player.play("hit")
	_health -= 1
	if _health <= 0:
		disable_shield()
	

func _on_area_entered(area: Area2D) -> void:
	hit()


func _on_timer_timeout() -> void:
	disable_shield()
