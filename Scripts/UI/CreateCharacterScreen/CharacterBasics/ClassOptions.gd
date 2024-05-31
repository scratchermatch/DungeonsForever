extends OptionButton

# Called when the node enters the scene tree for the first time.
func _ready():
	for item in DataLoader.classes.keys():
		add_item(item)
	PlayerLoader.data["classes"].append([get_item_text(selected), 1])

func _on_item_selected(index):
	####CHANGE LATER WHEN MULTICLASSING IS IMPLEMENTED!!!!!!!!!!!!
	PlayerLoader.data["classes"] = []
	PlayerLoader.data["classes"].append([get_item_text(index), int(PlayerLoader.data["level"])])
