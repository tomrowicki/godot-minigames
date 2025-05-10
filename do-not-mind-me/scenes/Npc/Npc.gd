extends CharacterBody2D


enum EnemyState {Patrolling, Chasing, Searching}


const SPEED: float = 100.0


@export var patrol_points: NodePath


@onready var nav_agent: NavigationAgent2D = $NavAgent
@onready var debug_label: Label = $DebugLabel


var _waypoints: Array[Vector2] = []
var _current_wp: int = 0
var _state: EnemyState = EnemyState.Patrolling


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("set_target"):
		nav_agent.target_position = get_global_mouse_position()


func _ready() -> void:
	create_wp()
	pass
	
func create_wp() -> void:
	for c in get_node(patrol_points).get_children():
		_waypoints.append(c.global_position)
	

func _physics_process(delta: float) -> void:
	update_movement()
	update_navigation()
	set_label()
	
	
func navigate_wp() -> void:
	if _waypoints.is_empty(): return
	
	nav_agent.target_position = _waypoints[_current_wp]
	_current_wp = (_current_wp + 1) % _waypoints.size()


func update_navigation() -> void:
	if nav_agent.is_navigation_finished():
		return
	
	# next position in path
	var npp: Vector2 = nav_agent.get_next_path_position()
	rotation = global_position.direction_to(npp).angle()
	# transform is the vector of where the object is facing
	#nav_agent.velocity = transform.x * SPEED # when computed _on_nav_agent_velocity_computed gets invoked
	
	velocity = transform.x * SPEED
	move_and_slide()


func process_patrolling() -> void:
	if nav_agent.is_navigation_finished():
		navigate_wp()


func update_movement() -> void:
	match _state:
		EnemyState.Patrolling:
			process_patrolling()


func set_label() -> void:
	var s: String = "Fin:%s\n" % nav_agent.is_navigation_finished()
	s += "TG_REA:%s\n" % nav_agent.is_target_reached()
	s += "CAN_REA:%s\n" % nav_agent.is_target_reachable()
	s += "TAR:%s\n" % nav_agent.target_position
	s += "ST:%s" % EnemyState.keys()[_state]
	
	debug_label.text = s


#func _on_nav_agent_velocity_computed(safe_velocity: Vector2) -> void:
	#velocity = safe_velocity
	#move_and_slide()
