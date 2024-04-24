extends Node

var book_translations:Dictionary

var items_filepath = "res://Assets/data/items.json"
var items:Array
var races_filepath = "res://Assets/data/races.json"
var races:Array
var class_index_filepath = "res://Assets/data/class/index.json"
var class_index:Dictionary
var books_filepath = "res://Assets/data/book/books.json"
var books:Array

func _ready():
	class_index = load_file(class_index_filepath)
	items = load_file(items_filepath)["item"]
	races = load_file(races_filepath)["race"]
	books = load_file(books_filepath)["book"]
	construct_books()

func check_exists(filepath):
	print("Opening file at " + filepath)
	if not FileAccess.file_exists(filepath):
		#Make sure that our data file is here
		print("File missing lol")
		return false
	return true

func read_file(filepath):
	#Open, read, and close the file
	var file = FileAccess.open(filepath, FileAccess.READ)
	var json_string = file.get_as_text()
	file.close()
	return json_string

func parse_data(json):
	print("Parsing JSON...")
	#Parse the data and load it into the items array
	var parsed_data = JSON.parse_string(json)
	return parsed_data
	
func load_file(filepath):
	if !check_exists(filepath):
		return
	var json_string = read_file(filepath)
	return parse_data(json_string)	

func construct_books():
	#Create a data structure to hold translations for book IDs
	for book in books:
		book_translations[book["id"]] = book["name"]
	print(book_translations)
