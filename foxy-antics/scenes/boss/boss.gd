extends Node2D


const TRIGGER_CONDITION: String = "parameters/conditions/on_trigger" # AnimationTree property


@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state_machine: AnimationNodeStateMachinePlayback = $AnimationTree["parameters/playback"] # typed by hand


var _invincible: bool = false


func set_invincible(v: bool) -> void:
	_invincible = v
	if (v):
		state_machine.travel("hit")
		
		
func take_damage() -> void:
	if _invincible:
		return
	
	set_invincible(true)


# when player triggers the boss by steping into the trigger area
func _on_trigger_area_entered(area: Area2D) -> void:
	animation_tree[TRIGGER_CONDITION] = true


func _on_hit_box_area_entered(area: Area2D) -> void:
	take_damage()
