extends CharacterBody2D

class_name Tappy

const GRAVITY: float = 1000.0
const POWER: float = -350.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	
	fly()
	
	# After setting the velocity we tell the physics engine to carry out the change;
	# it multiplies velocity by delta, so ultimately it's delta squared(?)
	move_and_slide()
	
	if is_on_floor():
		die()

func fly() -> void:
	if Input.is_action_just_pressed("fly"):
		velocity.y = POWER
		animation_player.play("power")

func die() -> void:
	animated_sprite.stop()
	set_physics_process(false)
	SignalManager.on_plane_died.emit()
