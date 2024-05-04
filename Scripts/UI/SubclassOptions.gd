extends OptionButton

@onready var class_options = %ClassOptions

func _ready():
	var name_of_class = class_options.get_item_text(0)
	for subclass in DataLoader.classes[name_of_class]["subclass"]:
		add_item(subclass["name"])

func _on_class_options_item_selected(index):
	clear()
	var name_of_class = class_options.get_item_text(index)
	for subclass in DataLoader.classes[name_of_class]["subclass"]:
		add_item(subclass["name"])
