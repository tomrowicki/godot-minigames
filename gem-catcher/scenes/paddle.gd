extends Area2D

# Export the property, so one can manipulate it in the inspector
@export var speed: float = 60.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		position.x -= speed * delta
		
	elif Input.is_action_pressed("right"):
		position.x += speed * delta
