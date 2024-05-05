extends OptionButton

# Called when the node enters the scene tree for the first time.
func _ready():
	for item in DataLoader.classes.keys():
		add_item(item)
	PlayerLoader.data["classes"][get_item_text(selected)] = 1

func _on_item_selected(index):
	####CHANGE LATER WHEN MULTICLASSING IS IMPLEMENTED!!!!!!!!!!!!
	PlayerLoader.data["classes"][get_item_text(index)] = PlayerLoader.data["level"]
	###THIS CAN BE BUGGY
