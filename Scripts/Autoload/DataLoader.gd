extends Node
#Data Loader should only be reading and parsing files. It can store data
#structures universal to everybody if they are alternatives to raw data.
#All data stored here should be read-only

var book_translations:Dictionary
var default_races:Array #Adds uniquity to conflicting race names
var all_races:Array

var items_filepath = "res://Assets/data/items.json"
var _item_dictionary:Dictionary #Holds the items AND the item groups
var items:Array
var item_groups:Array
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
#class_info has keys: class, classFeature, subclass, subclass feature
var class_features:Dictionary

func _ready():
	_item_dictionary = load_file(items_filepath)
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

func _construct_items():
	items = _item_dictionary["item"]
	item_groups = _item_dictionary["itemGroup"]

#creates class features in form: 
#{"class":{"FeatureName":[Feature Level, Feature Description, other data}}
func parse_class_feature(feature):
	var feature_dict:Dictionary = {}
	var feature_text:String #usually in the form name|class|book|level
	if typeof(feature) == TYPE_DICTIONARY: #as is with subclass features
		feature_text = feature["classFeature"]
		feature_dict["subclass"] = true
	else:
		feature_text = feature
		feature_dict["subclass"] = false
	feature_dict["name"] = feature_text.get_slice("|", 0)
	feature_dict["class"] = feature_text.get_slice("|", 1)
	feature_dict["level"] = int(feature_text.get_slice("|", 3))
	for item in classes[feature_dict["class"]]["classFeature"]:
		if item["name"] == feature_dict["name"] and \
		item["level"] == feature_dict["level"]:
			feature_dict["desc"] = " ".join(item["entries"])
	return feature_dict

#Recursively fills in all the tags and json objects with their respective values
#Returns the text without any {}
#child helps it determine whether it is being called by itself
func parse_text(text, _child = false):
	text = text.c_unescape() #The text escapes ' and that breaks the JSON parser
	while "{" in text: #Repeat until all {} are stripped
		var start = text.find("{")
		if text[start + 1] == "@":
			var end = find_ending_bracket(text, "{", "}")
			var final = parse_tag(text.substr(start + 1, end - start -1))
			var substr = text.substr(start, end - start + 1)
			print("\nReplacing ", substr, " with ", final, "\n")
			text = text.replace(substr, final)
		else:
			#We now need to find out which } because of nesting
			var end = find_ending_bracket(text, "{", "}")
			var substr = (text.substr(start +1, end - start - 1))
			#The issue is this isn't valid json until all the tags are parsed.
			#We stripped the {} in the substring, and now we parse
			var new_substr:String #We have to replace them out here because this
			#is where we remember the tags inside the dictionary
			if "{" in substr:
				print("\nrecursing with text: '", substr, "'\n")
				new_substr = "{" + parse_text(substr, true) + "}"
				substr = "{" + substr + "}" 
				#Give it back it's {} so we can replace text with it later
			else:
				substr = "{" + substr + "}"
				new_substr = substr
				print("\nLast recursion, parsing: ", substr, "\n")
			#And now we can parse the dictionary after ensuring that it's valid
			var parsed_dict = safe_parse_json(new_substr, TYPE_DICTIONARY)
			var final = "" #We'll be concatenating to this throughout
			
			match parsed_dict["type"]:
				"entries", "inset":
					final += "\"\n"
					final += bbcode(parsed_dict["name"], "b")
					final += ": \n" #bold and newline the title
					for entry in parsed_dict["entries"]:
						final += entry
						final += "\n"
					final += "\""
				"abilityAttackMod":
					final = "\"\"" 
				"abilityDc":
					final = "\"\""
				"list":
					final = "\"\n"
					for item in parsed_dict["items"]:
						final += " - " + item
						final += ("\n")
				_:
					final = "\"\"" #These all have to be valid JSON strings
			print("\n\nReplacing\n\n", substr, "\n\nwith\n\n", final, "\n")
			text = text.replace(substr, final)
	if _child == false:
		text = text.replace("\"", "")
	print("Returning:\n", text)
	return text

#Returns what text the tag should be replaced with
func parse_tag(tag): #Tag should be everything after and including the @ sign
	var word = tag.substr(1, tag.find(" ") - 1) #The tag name
	var remainder = tag.substr(tag.find(" ") + 1) #Everything after the name
	print("\nWord: ", word, " Remainder: ", remainder, "\n")
	#Time to slice and dice!
	match word:
		"dice":
			return remainder
		"filter":
			return remainder
		"book":
			return remainder
		"spell":
			return remainder
		"item":
			return remainder
		"i":
			return remainder
		"5etools":
			return remainder
		_:
			return remainder

#Returns the position of the close character starting from the open one in text
func find_ending_bracket(text, open, close):
	var stack = []
	for i in range(len(text)):
		if text[i] == open:
			stack.push_back(i)
		if text[i] == close:
			if len(stack) == 1:
				#popping this would remove the last item from stack,
				#therefore it is the close character
				return i
			else:
				stack.pop_back()
	return("Error: couldn't find the close character " + close)

func bbcode(text, format):
	match format.to_lower():
		"bold", "b":
			return "[b]" + text + "[/b]"

#This shouldn't be necessary. Removes double quotes from strings in arrays in
#dictionaries in JSON files that prevent them from being parsed correctly.

func remove_rogue_double_quotes(text):
	#I don't know the full structure of this massive json system just yet
	#But from what I can tell, custom text entries only occur within arrays with
	#the keys "entries" and "list". I will be a bit more broad and scan any 
	#arrays with a quote after them (in the form ["). And thus it begins.
	print("\nremoving rogue quotes\n")
	var start = 0
	while "[" in text.substr(start):
		start = text.find("[", start)
		var end = find_ending_bracket(text, "[", "]")
		#Searches every " between the []
		if text[start + 1] == "\"":
			#Narrow the search down to individual lists
			var substr = text.substr(start, end - start + 1)
			var final = substr #Can't edit substr since we have to replace later
			var quote_start = 1 #don't check the first quote
			while final.find("\"", quote_start) != -1:
				var quote_end = final.find("\"", quote_start + 1)
				if final[quote_end + 1] not in [",", ":", "]"]:
					final = final.insert(quote_end, "\\") #Escape the evil "
					quote_end += 1 #Adjust index to account for different size
					final = final.insert(final.find("\"", quote_end + 1), "\\")
					quote_end += 2 #Start next search after the last escaped "
				#Adjust start index for next iteration
				quote_start = final.find("\"", quote_end + 1)
				if quote_start > len(final):
					quote_start = -1
			text = text.replace(substr, final)
			start = start + quote_start
		start = end
	print("Removed quotes, returning:\n\n", text, "\n\n")
	return text

func safe_parse_json(text, expected_type):
	if typeof(text) != TYPE_STRING:
		assert(false, "Cannot parse a non string object")
	var parsed_data #Where this data will be stored
	var json = JSON.new()
	var result = json.parse(text)
	if result != OK:
		if json.get_error_message() == "Expected ','":
			#All heck bouta break loose.
			#Whoever made the JSON let some of the entries contain double quotes
			#This confuses the parser, because now it  misinterprets the array
			#containing all the entries as having another key value pair in
			#its parent dictionary. So sometimes it throws an error claiming
			#a missing comma. So now I gotta double parse it to fix the ""
			text = remove_rogue_double_quotes(text)
			parsed_data = safe_parse_json(text, expected_type)
		else:
			print("\nJSON Parse Error: ", json.get_error_message(), " in ",
				text, " at line ", json.get_error_line())
			print("\nThis is the text I failed to parse: " + text + "\n")
			assert(false, "parsing failed")
	else:
		if typeof(json.data) == expected_type:
			print("Parsed JSON successfully")
		else:
			push_error("The parser did not create the expected type (",
			 expected_type, ")") #Yes, this happens
		parsed_data = json.data
	return parsed_data
