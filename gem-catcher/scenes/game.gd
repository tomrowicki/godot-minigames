extends Node2D

@export var gem_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Spawning a gem at the beginning of the game
	spawn_gem()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	
func spawn_gem() -> void:
	# Typing allows intellisense to get access to methods proper
	var new_gem: Gem = gem_scene.instantiate()
	var x_pos: float = randf_range(70, 1050)
	new_gem.on_gem_off_screen.connect(game_over)
	new_gem.position = Vector2(x_pos, -50)
	add_child(new_gem)
	
func game_over() -> void:
	print("game over")


func _on_timer_timeout() -> void:
	spawn_gem()
