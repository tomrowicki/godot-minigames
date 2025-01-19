extends Resource


class_name ImageFilesList


@export var file_names: Array[String]


func add_filename(fn: String) -> void:
	file_names.append(fn)
	
func get_filenames() -> Array[String]:
	return file_names
