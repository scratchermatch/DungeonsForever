extends Button

const INFO_POPUP = preload("res://Scenes/info_popup.tscn")

@onready var class_options = %ClassOptions

func _on_pressed():
	var class_popup = INFO_POPUP.instantiate()
	get_tree().root.add_child(class_popup)
	class_popup.init("Class Features", "These are the features :)")
