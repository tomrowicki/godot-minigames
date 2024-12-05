extends CharacterBody2D

const GRAVITY: float = 300.0
const POWER: float = -200.0

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	
	fly()
	
	# After setting the velocity we tell the physics engine to carry out the change;
	# it multiplies velocity by delta, so ultimately it's delta squared(?)
	move_and_slide()

func fly() -> void:
	if Input.is_action_just_pressed("fly"):
		velocity.y = POWER
