extends Control

@onready var title_label = %TitleLabel
@onready var contents_label = %ContentsLabel
@onready var more_info_button = %MoreInfoButton

@export var title_text:String
@export var contents_text:String
@export var button:bool = false

func init(title:String, contents:String, button_shown:bool = false):
	title_label.text = title
	contents_label.text = contents
	more_info_button.visible = button_shown


func _on_back_button_pressed():
	queue_free()
