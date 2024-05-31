extends Node
#Player loader holds information about the current player, stats, features, etc.
#For everybody to share around.
var characters:Array #Array of located character files

#To be read from the character file. Contains default values here.
var defaults = {
	"name" : "",
	"level" : 1,
	"classes" : [], #Contains [[Class, level], [Class, level]]
	"subclasses" : [], #Contains [[Class, Subclass],[class, sublclass]]
	"race" : "",
	"subrace" : "",
	"current_health" : 0,
	"max_health" : 0,
	"experience" : 0,
	"ability_scores" : {
		"str" : 8,
		"dex" : 8,
		"con" : 8,
		"int" : 8,
		"wis" : 8,
		"cha" : 8
	},
	"background" : "",
	"alignment" : "",
	"skills" : {}
}

#To be derived at runtime
var num_dice:int #the 4 in 4d8
var num_faces:int #the 8 in 4d8
var proficiency_bonus:int
var speed:Dictionary #Walking: 30, Flying: 30, etc.
var save_proficiencies:Dictionary

var data = defaults

var class_features:Array #An array of dictionaries

func load_character(filepath):
	data = DataLoader.load_file(filepath)

func save_character():
	if data["name"] == "":
		print("You aint typed nothin kid")
		data["name"] = "I was too cool to type a name"
	var filename = "user://" + data["name"].replace(" ", "_") + ".dfc"
	var json_string = JSON.stringify(data, "\t")
	var save_game = FileAccess.open(filename, FileAccess.WRITE)
	save_game.store_line(json_string)

func hard_pass():
	pass
	pass
