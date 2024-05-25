extends OptionButton

# Called when the node enters the scene tree for the first time.
func _ready():
	for item in DataLoader.backgrounds:
		add_item(item["name"])
	PlayerLoader.data["background"] = get_item_text(selected)

func _on_item_selected(index):
	PlayerLoader.data["background"] = get_item_text(index)
