extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_random_image()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_random_image() -> void:
	texture = ImageManager.get_random_item_image().get_texture()
