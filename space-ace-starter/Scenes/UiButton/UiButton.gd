extends TextureButton

class_name UiButton


@export var button_text: String


@onready var label: Label = $Label


func _ready() -> void:
	label.text = button_text
