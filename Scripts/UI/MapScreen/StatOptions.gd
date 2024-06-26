extends OptionButton

@onready var score_vbox = %ScoreVBox
@onready var mod_vbox = %ModVBox
@onready var save_vbox = %SaveVBox

func _on_item_selected(index):
	if index == 0:
		score_vbox.visible = true
		mod_vbox.visible = false
		save_vbox.visible = false
	elif index == 1:
		score_vbox.visible = false
		mod_vbox.visible = true
		save_vbox.visible = false
	elif index == 2:
		score_vbox.visible = false
		mod_vbox.visible = false
		save_vbox.visible = true
	else:
		print("This shouldn't occur! Invalid index for stat option button.")
