extends OptionButton

var sources:Array

# Called when the node enters the scene tree for the first time.
func _ready():
	for key in DataLoader.classes.keys():
		var book = DataLoader.classes[key]["class"][0]["source"]
		if !book in sources:
			sources.append(book)

	for source in sources:
		add_item(source)
