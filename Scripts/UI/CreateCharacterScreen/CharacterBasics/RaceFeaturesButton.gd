extends Button

const INFO_POPUP = preload("res://Scenes/info_popup.tscn")

@onready var race_options = %RaceOptions


func _on_pressed():
	var race_popup = INFO_POPUP.instantiate()
	get_tree().root.add_child(race_popup)
	race_popup.init("Race Features", "These are the features :)")
