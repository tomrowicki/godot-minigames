extends TextureButton

const HOVER_SCALE: Vector2 = Vector2(1.1, 1.1)
const DEFAULT_SCALE: Vector2 = Vector2(1.0, 1.0)

@export var level_number: int = 1

@onready var level_label: Label = $MarginContainer/VBoxContainer/LevelLabel
@onready var score_label: Label = $MarginContainer/VBoxContainer/ScoreLabel

var _level_scene: PackedScene

# Called three times (once for each of the buttons)
func _ready() -> void:
	_level_scene = load("res://scenes/level/level%s.tscn" % level_number) 
	level_label.text = str(level_number)

func _on_pressed() -> void:
	ScoreManager.set_level_selected(level_number)
	get_tree().change_scene_to_packed(_level_scene)


func _on_mouse_entered() -> void:
	scale = HOVER_SCALE


func _on_mouse_exited() -> void:
	scale = DEFAULT_SCALE
