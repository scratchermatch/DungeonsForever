extends OptionButton

@onready var race_options = %RaceOptions

func _ready():
	populate_subraces(race_options.selected)
	if selected != -1:
		PlayerLoader.data["subrace"] = get_item_text(selected)
	else:
		PlayerLoader.data["subrace"] = "None"

func _on_race_options_item_selected(index):
	populate_subraces(index)
	if selected != -1:
		PlayerLoader.data["subrace"] = get_item_text(selected)
	else:
		PlayerLoader.data["subrace"] = "None"

func populate_subraces(index):
	clear()
	var full_name = race_options.get_item_text(index)
	var race_data = DataLoader.parse_race(full_name) #In the form [source, name]
	var default_subraces:Array = [] #For nice sorting with default coming first
	var all_subraces:Array
	var default = false #If PHB has an option for no subrace
	for subrace in DataLoader.races["subrace"]:
		if subrace["raceName"]==race_data[0] and subrace["raceSource"]==race_data[1]:
			if subrace.has("name"):
				if subrace["source"] != "PHB":
					all_subraces.append("(" + subrace["source"] + ") " + subrace["name"])
				else:
					default_subraces.append(subrace["name"])
			else:
				default = true
	if default == true:
		default_subraces.push_front("Default")
	all_subraces = default_subraces + all_subraces
	for item in all_subraces:
		add_item(item)


func _on_item_selected(index):
	PlayerLoader.data["subrace"] = get_item_text(index)
