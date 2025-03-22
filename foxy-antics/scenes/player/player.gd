extends CharacterBody2D


class_name Player


enum PlayerState {IDLE, RUN, JUMP, FALL, HURT}


const FALLEN_OFF: float = 200.0
const GRAVITY: float = 690.0
const RUN_SPEED: float = 120.0
const MAX_FALL: float = 400.0
const JUMP_VELOCITY: float = -260.0
const HURT_JUMP_VELOCITY: Vector2 = Vector2(0, -130.0)

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var debug_label: Label = $DebugLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var shooter: Shooter = $Shooter
@onready var invincible_timer: Timer = $InvincibleTimer
@onready var invincible_player: AnimationPlayer = $InvinciblePlayer
@onready var hurt_timer: Timer = $HurtTimer
@onready var sound: AudioStreamPlayer2D = $Sound



var _state: PlayerState = PlayerState.IDLE
var _invincible: bool = false
var _lives: int = 3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Making sure that hud's been initialised prior to emitting the signal
	call_deferred("deferred_setup")
	

func deferred_setup() -> void:
	SignalManager.on_level_started.emit(_lives)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	fallen_off()
	
	if is_on_floor() == false:
		velocity.y += GRAVITY * delta
		
	get_input()
	move_and_slide()
	calculate_states()
	update_debug_label()
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
		
		
func fallen_off() -> void:
	if global_position.y < FALLEN_OFF:
		return
	reduce_lives(_lives)


func update_debug_label() -> void:
	debug_label.text = "floor:%s inv:%s\n%s\nvel:(%.0f,%.0f)\nlives:%d" % [is_on_floor(), _invincible, 
	PlayerState.keys()[_state], velocity.x, velocity.y, _lives]


func shoot() -> void:
	if sprite_2d.flip_h:
		shooter.shoot(Vector2.LEFT)
	else:
		shooter.shoot(Vector2.RIGHT)


func get_input() -> void:
	if _state == PlayerState.HURT:
		return
	
	velocity.x = 0
	
	if Input.is_action_pressed("left"):
		velocity.x = -RUN_SPEED
		sprite_2d.flip_h = true
	
	elif Input.is_action_pressed("right"):
		velocity.x = RUN_SPEED
		sprite_2d.flip_h = false
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		SoundManager.play_clip(sound, SoundManager.SOUND_JUMP)
		
	velocity.y = clampf(velocity.y, JUMP_VELOCITY, MAX_FALL)


func calculate_states() -> void:
	if _state == PlayerState.HURT:
		return
	
	if is_on_floor():
		if velocity.x == 0:
			set_state(PlayerState.IDLE)
		else:
			set_state(PlayerState.RUN)
	else:
		if velocity.y > 0:
			set_state(PlayerState.FALL)
		else:
			set_state(PlayerState.JUMP)


func set_state(new_state: PlayerState) -> void:
	if new_state == _state:
		return
	
	if _state == PlayerState.FALL:
		if new_state == PlayerState.IDLE or new_state == PlayerState.RUN:
			SoundManager.play_clip(sound, SoundManager.SOUND_LAND)
	
	_state = new_state	

	match _state:
		PlayerState.IDLE:
			animation_player.play("idle")
		PlayerState.RUN:
			animation_player.play("run")
		PlayerState.JUMP:
			animation_player.play("jump")
		PlayerState.FALL:
			animation_player.play("fall")
		PlayerState.HURT:
			apply_hurt_jump()


func reduce_lives(reduction: int) -> bool:
	_lives -= reduction
	SignalManager.on_player_hit.emit(_lives)
	if _lives <= 0:
		SignalManager.on_game_over.emit()
		set_physics_process(false)
		return false
		
	return true

func go_invincible() -> void:
	_invincible = true
	invincible_player.play("invincible")
	invincible_timer.start()


func apply_hurt_jump() -> void:
	animation_player.play("hurt")
	velocity = HURT_JUMP_VELOCITY
	hurt_timer.start()
	

func apply_hit() -> void:
	if _invincible:
		return
		
	if !reduce_lives(1):
		return
		
	SoundManager.play_clip(sound, SoundManager.SOUND_DAMAGE)	
	go_invincible()
	set_state(PlayerState.HURT)

func _on_invincible_timer_timeout() -> void:
	_invincible = false
	invincible_player.stop()


func _on_hit_box_area_entered(_area: Area2D) -> void:
	apply_hit()


func _on_hurt_timer_timeout() -> void:
	set_state(PlayerState.IDLE)
