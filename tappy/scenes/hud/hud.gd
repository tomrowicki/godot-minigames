extends Control

@onready var score_label: Label = $ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.on_score_updated.connect(update_score)
	
func update_score(score: int) -> void:
	score_label.text = str(score)
