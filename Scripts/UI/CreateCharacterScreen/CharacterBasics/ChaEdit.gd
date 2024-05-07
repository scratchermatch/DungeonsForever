extends SpinBox


func _on_value_changed(value):
	PlayerLoader.data["ability_scores"]["cha"] = value
