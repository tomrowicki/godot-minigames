extends Area2D

# Allows type reference
class_name Gem

# Custom signal
signal on_gem_off_screen

# Export the property, so one can manipulate it in the inspector
@export var speed: float = 100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += speed * delta
	
	if position.y > get_viewport_rect().size.y:
		on_gem_off_screen.emit()
		set_process(false) # so this process func is no longer invoked for this node
		queue_free()
		
