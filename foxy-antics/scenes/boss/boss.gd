extends Node2D


const TRIGGER_CONDITION: String = "parameters/conditions/on_trigger" # AnimationTree property


@export var lives: int = 2
@export var points: int = 5


@onready var hit_box: Area2D = $Visual/HitBox
@onready var visual: Node2D = $Visual
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state_machine: AnimationNodeStateMachinePlayback = $AnimationTree["parameters/playback"] # typed by hand


var _invincible: bool = false

func reduce_lives() -> void:
	lives -= 1
	if lives <= 0:
		SignalManager.on_boss_killed.emit(points)
		queue_free()


# used to animate boss properly after he takes a hit (he moves back to original pos slowly)
func tween_hit() -> void:
	var tween = create_tween()
	tween.tween_property(visual, "position", Vector2.ZERO, 1.6)


func set_invincible(v: bool) -> void:
	_invincible = v
	if (v):
		state_machine.travel("hit")
		
		
func take_damage() -> void:
	if _invincible:
		return
	
	set_invincible(true)
	tween_hit()
	reduce_lives()


# when player triggers the boss by steping into the trigger area
func _on_trigger_area_entered(area: Area2D) -> void:
	animation_tree[TRIGGER_CONDITION] = true
	hit_box.monitoring = true
	

func _on_hit_box_area_entered(area: Area2D) -> void:
	take_damage()
