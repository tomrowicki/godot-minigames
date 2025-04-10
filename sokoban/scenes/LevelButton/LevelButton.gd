extends NinePatchRect

class_name LevelButton

@onready var level_label: Label = $LevelLabel
@onready var check_mark: TextureRect = $CheckMark


var _level_number: String = "99"


func _ready() -> void:
	level_label.text = _level_number
	check_mark.visible = GameManager.has_level_score(_level_number)
	
	
func setup(ln: String) -> void:
	_level_number = ln


# Requires mouse filtering to be setup properly to work (LevelButton's Inspector -> Control
# -> Mouse -> Filter = Stop
func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("select"):
		GameManager.load_level_scene(_level_number)
