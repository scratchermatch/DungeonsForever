extends ItemList

@onready var class_options = %ClassOptions
@onready var feature_description = %FeatureDescription

var features:Array = []

func _ready():
	var class_features = DataLoader.classes[class_options.get_item_text(class_options.selected)]["class"][0]["classFeatures"]
	for feature in class_features:
		var feature_data = DataLoader.parse_class_feature(feature)
		features.append(feature_data)
		add_item(str(feature_data["level"]) + " " + feature_data["name"])
		feature_description.text = ""

func _on_class_options_item_selected(index):
	features = []
	clear()
	var class_features = DataLoader.classes[class_options.get_item_text(index)]["class"][0]["classFeatures"]
	for feature in class_features:
		var feature_data = DataLoader.parse_class_feature(feature)
		features.append(feature_data)
		add_item(str(feature_data["level"]) + " " + feature_data["name"])
	feature_description.text = ""

func _on_item_selected(index):
	#print("\nI'm sending\n\n", features[index]["desc"], "\n\nto be parsed!")
	feature_description.text = DataLoader.parse_text(features[index]["desc"])
