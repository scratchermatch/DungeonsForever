extends Node
#Data Loader should only be reading and parsing files. It can store data
#structures universal to everybody if they are alternatives to raw data.
#All data stored here should be read-only

var book_translations:Dictionary
var default_races:Array #Adds uniquity to conflicting race names
var all_races:Array

var items_filepath = "res://Assets/data/items.json"
var items:Array
var races_filepath = "res://Assets/data/races.json"
var races:Dictionary
var class_index_filepath = "res://Assets/data/class/index.json"
var class_index:Dictionary #meta, race, subrace : data
var books_filepath = "res://Assets/data/book/books.json"
var books:Array
var backgrounds_filepath = "res://Assets/data/backgrounds.json"
var backgrounds:Array
var class_filepaths = [
	"res://Assets/data/class/class-artificer.json",
	"res://Assets/data/class/class-barbarian.json",
	"res://Assets/data/class/class-bard.json",
	"res://Assets/data/class/class-cleric.json",
	"res://Assets/data/class/class-druid.json",
	"res://Assets/data/class/class-fighter.json",
	"res://Assets/data/class/class-monk.json",
	"res://Assets/data/class/class-mystic.json",
	"res://Assets/data/class/class-paladin.json",
	"res://Assets/data/class/class-ranger.json",
	"res://Assets/data/class/class-rogue.json",
	#The sidekick class has a different format than the rest, so it breaks
	#"res://Assets/data/class/class-sidekick.json",
	"res://Assets/data/class/class-sorcerer.json",
	"res://Assets/data/class/class-warlock.json",
	"res://Assets/data/class/class-wizard.json"
]
var classes:Dictionary #In the form class_name: class_info
#class_info has keys: class, class feature, subclass, subclass feature

func _ready():
	items = load_file(items_filepath)["item"]
	races = load_file(races_filepath)
	_construct_races()
	books = load_file(books_filepath)["book"]
	_construct_books()
	backgrounds = load_file(backgrounds_filepath)["background"]
	for filepath in class_filepaths:
		var temp = load_file(filepath)
		classes[temp["class"][0]["name"]] = temp
		

func _check_exists(filepath):
	print("Opening file at " + filepath)
	if not FileAccess.file_exists(filepath):
		#Make sure that our data file is here
		print("File missing lol")
		return false
	return true

func _read_file(filepath):
	#Open, read, and close the file
	var file = FileAccess.open(filepath, FileAccess.READ)
	var json_string = file.get_as_text()
	file.close()
	return json_string

func _parse_data(json):
	print("Parsing JSON...")
	#Parse the data and load it into the items array
	var parsed_data = JSON.parse_string(json)
	return parsed_data
	
func load_file(filepath):
	if !_check_exists(filepath):
		return
	var json_string = _read_file(filepath)
	return _parse_data(json_string)	

func _construct_books():
	#Create a data structure to hold translations for book IDs
	print("Translating book mnemonics")
	for book in books:
		book_translations[book["id"]] = book["name"]

func _construct_races():
	print("Constructing race sources")
	for race in races["race"]:
		if race["source"] != "PHB":
			all_races.append("(" + race["source"] + ") " + race["name"])
		else:
			default_races.append(race["name"])
	all_races = default_races + all_races

func parse_race(race): #returns [name, source]
	var race_source
	var race_name
	var idx = race.find(")")
	if idx == -1:
		race_source = "PHB"
		race_name = race
	else:
		race_source = race.substr(1, idx - 1)
		race_name = race.substr(idx + 2, race.length())
	return [race_name, race_source]
