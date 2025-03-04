extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.on_game_over.connect(on_game_over)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("bullet"):
		SignalManager.on_create_bullet.emit(
			Vector2(400, -50), 
			Vector2(50, -50),
			3.0,
			40.0,
			Constants.ObjectType.BULLET_PLAYER
		)


func on_game_over() -> void:
	for movable in get_tree().get_nodes_in_group(Constants.MOVEABLES_GROUP):
		movable.set_process(false)
		movable.set_physics_process(false)
