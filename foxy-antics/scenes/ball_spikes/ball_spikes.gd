extends PathFollow2D


@export var speed: float = 0.05
@export var spin_speed: float = 400


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_ratio += delta * speed
	rotation_degrees += spin_speed * delta
