extends OptionButton

# Called when the node enters the scene tree for the first time.
func _ready():
	for race in DataLoader.all_races:
		add_item(race)
	PlayerLoader.data["race"] = get_item_text(selected)

func _on_item_selected(index):
	PlayerLoader.data["race"] = get_item_text(index)
