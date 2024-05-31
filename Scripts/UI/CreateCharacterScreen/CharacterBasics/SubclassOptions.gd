extends OptionButton

@onready var class_options = %ClassOptions

func _ready():
	var name_of_class = class_options.get_item_text(0)
	for subclass in DataLoader.classes[name_of_class]["subclass"]:
		add_item(subclass["name"])
	PlayerLoader.data["subclasses"].append([class_options.get_item_text(0), get_item_text(selected)])

func _on_class_options_item_selected(index):
	clear()
	var name_of_class = class_options.get_item_text(index)
	if DataLoader.classes[name_of_class].has("subclass"):
		for subclass in DataLoader.classes[name_of_class]["subclass"]:
			add_item(subclass["name"])
	else:
		add_item("Default") #If the class doesn't have subclass options

func _on_item_selected(index):
	#This breaks when multiclassing is implemented
	var current_class = class_options.get_item_text(class_options.selected)
	PlayerLoader.data["subclasses"] = []
	PlayerLoader.data["subclasses"].append([current_class, get_item_text(index)])
