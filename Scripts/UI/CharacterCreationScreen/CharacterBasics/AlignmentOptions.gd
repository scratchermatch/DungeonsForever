extends OptionButton

func _ready():
	PlayerLoader.data["alignment"] = get_item_text(selected)

func _on_item_selected(index):
	PlayerLoader.data["alignment"] = get_item_text(index)
