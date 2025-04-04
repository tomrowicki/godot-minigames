extends Control


@onready var grid_container: GridContainer = $MC/VB/GridContainer

const LEVEL_BUTTON = preload("res://scenes/LevelButton/LevelButton.tscn")

const LEVELS_COUNT: int = 30



func _ready() -> void:
	setup_grid()


func setup_grid() -> void:
	for ln in LEVELS_COUNT:
		var level_button : LevelButton = LEVEL_BUTTON.instantiate()
		level_button.setup(str(ln + 1))
		#var buttonLabel: Label = level_button.find_child("LevelLabel")
		grid_container.add_child(level_button)
