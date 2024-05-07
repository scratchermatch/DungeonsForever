extends Control

@onready var file_v_box = %FileVBox

const PLAYER_FILE_BOX = preload("res://Scenes/player_file_box.tscn")
var filepath_prefix = "user://"
# Called when the node enters the scene tree for the first time.
func _ready():
	var dir = DirAccess.open(filepath_prefix)
	if dir:
		var files = dir.get_files()
		for file in files:
			if file.ends_with(".dfc"):
				var file_button = PLAYER_FILE_BOX.instantiate()
				var player_data = DataLoader.load_file(filepath_prefix + file)
				file_v_box.add_child(file_button)
				file_button.init(player_data)
