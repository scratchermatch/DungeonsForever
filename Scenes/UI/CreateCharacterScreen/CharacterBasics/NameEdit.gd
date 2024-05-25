extends LineEdit

func _ready():
	PlayerLoader.data["name"] = "Unnamed Character"

func _on_text_changed(new_text):
	PlayerLoader.data["name"] = new_text
