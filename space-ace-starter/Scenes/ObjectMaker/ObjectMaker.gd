extends Node2D


const ADD_OBJECT: String = "add_object"

const EXPLOSION = preload("res://Scenes/Explosion/Explosion.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_create_explosion.connect(add_explosion)


func add_object(obj: Node, pos: Vector2) -> void:
	add_child(obj)
	obj.global_position = pos


func add_explosion(pos: Vector2, animation_name: String) -> void:
	var explosion: Explosion = EXPLOSION.instantiate()
	explosion.setup(animation_name)
	call_deferred(ADD_OBJECT, explosion, pos)
