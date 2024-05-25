extends Control

@onready var title_label = %TitleLabel
@onready var contents_label = %ContentsLabel
@onready var more_info_button = %MoreInfoButton

func init(title:String, contents:String, button_shown:bool = false):
	more_info_button.visible = button_shown
	title_label.text = title
	contents_label.text = contents
