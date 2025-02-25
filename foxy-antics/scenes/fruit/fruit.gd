extends Area2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


const GRAVITY: float = 160.0
const JUMP: float = -120.0
const POINTS: int = 2

var _start_y: float
var _speed_y: float = JUMP


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_start_y = position.y
	# picking animations at random
	var list_of_names: Array[String] = []
	for animation in animated_sprite_2d.sprite_frames.get_animation_names():
		list_of_names.push_back(animation)
	animated_sprite_2d.animation = list_of_names.pick_random()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += _speed_y * delta
	_speed_y += GRAVITY * delta
	
	if position.y > _start_y:
		set_process(false)
		
		
func kill_me() -> void:
	hide()
	queue_free()


func _on_life_timer_timeout() -> void:
	kill_me()


func _on_area_entered(area: Area2D) -> void:
	SignalManager.on_pickup_hit.emit(POINTS)
	kill_me()
