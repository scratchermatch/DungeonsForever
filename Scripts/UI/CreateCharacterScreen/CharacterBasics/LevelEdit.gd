extends SpinBox

func _ready():
	PlayerLoader.data["level"] = 1
<<<<<<< HEAD
=======
	
>>>>>>> 0bd3c69 (Attempted to stop the large file from being tracked once and for all)

func _on_value_changed(value):
	PlayerLoader.data["level"] = value
