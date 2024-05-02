extends OptionButton

#These are populated by construct_sources()
var race_sources:Array = [] #All possible book sources
var source_dict:Dictionary = {} # race: book


# Called when the node enters the scene tree for the first time.
func _ready():
	construct_sources()
	var idx = 1
	for source in race_sources:
		add_item(source)
		if DataLoader.book_translations.has(source):
			set_item_tooltip(idx, DataLoader.book_translations[source])
		idx += 1

func construct_sources():
	print("Parsing race sources...")
	for race in DataLoader.races:
		source_dict[race["name"]] = race["source"]
		if !race["source"] in race_sources: 
			race_sources.append(race["source"])
