extends SpinBox

func _ready():
	PlayerLoader.data["level"] = 1

func _on_value_changed(value):
	PlayerLoader.data["level"] = value
