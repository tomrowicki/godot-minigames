extends Node2D

@export var gem_scene: PackedScene

# Provides access to the child note when ready, can generate automatically by holding ctrl
# and dragging the node from the node list inside script
@onready var label: Label = $Label

# The convention is to use underscore for fields, and lack thereof for local variables
var _score: int = 0

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


func _on_paddle_area_entered(area: Area2D) -> void:
	_score += 1
	label.text = "%05d" % _score
	# Deleting the gem
	area.queue_free()
