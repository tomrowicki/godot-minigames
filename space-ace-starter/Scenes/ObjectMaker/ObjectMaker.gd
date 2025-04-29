extends Node2D


const ADD_OBJECT: String = "add_object"

const EXPLOSION = preload("res://Scenes/Explosion/Explosion.tscn")
const POWER_UP = preload("res://Scenes/Projectile/PowerUp/PowerUp.tscn")

const BULLET_BOMB = preload("res://Scenes/Projectile/Bullets/BulletBomb.tscn")
const BULLET_ENEMY = preload("res://Scenes/Projectile/Bullets/BulletEnemy.tscn")
const BULLET_PLAYER = preload("res://Scenes/Projectile/Bullets/BulletPlayer.tscn")

const HOMING_MISSILE = preload("res://Scenes/Projectile/HomingMissile/HomingMissile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_create_explosion.connect(add_explosion)
	SignalHub.on_powerup_init.connect(add_powerup)
	SignalHub.on_create_bullet.connect(on_create_bullet)
	SignalHub.on_create_homing_missile.connect(on_create_homing_missile)


func add_object(obj: Node, pos: Vector2) -> void:
	add_child(obj)
	obj.global_position = pos


func add_explosion(pos: Vector2, animation_name: String) -> void:
	var explosion: Explosion = EXPLOSION.instantiate()
	explosion.setup(animation_name)
	call_deferred(ADD_OBJECT, explosion, pos)
	
	
func add_powerup(pos: Vector2, type: PowerUp.PowerUpType) -> void:
	var powerup: PowerUp = POWER_UP.instantiate()
	powerup.power_up_type = type
	call_deferred(ADD_OBJECT, powerup, pos)
	
	
func on_create_bullet(pos: Vector2, 
					dir: Vector2, 
					speed: float, 
					bu_type: BulletBase.BulletType ) -> void:
	var scene: BulletBase
	match bu_type:
		BulletBase.BulletType.Player:
			scene = BULLET_PLAYER.instantiate()
		BulletBase.BulletType.Enemy:
			scene = BULLET_ENEMY.instantiate()
		BulletBase.BulletType.Bomb:
			scene = BULLET_BOMB.instantiate()
	if scene:
		scene.setup(dir, speed)
		call_deferred(ADD_OBJECT, scene, pos)
		
		
func on_create_homing_missile(start_pos: Vector2) -> void:
	var hm: HomingMissle = HOMING_MISSILE.instantiate()
	call_deferred(ADD_OBJECT, hm, start_pos)
