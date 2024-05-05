extends Label

@onready var class_options = %ClassOptions
@onready var number
@onready var faces

func _ready():
	set_hit_dice_label(class_options.selected)

func _on_class_options_item_selected(index):
	set_hit_dice_label(index)
	
#Takes the index of the class optionsbutton
func set_hit_dice_label(index):
	#Why is class_name reserved? How silly
	var name_of_class = class_options.get_item_text(index)
	var hit_dice_dict = DataLoader.classes[name_of_class]["class"][0]["hd"]
	number = hit_dice_dict["number"]
	faces = hit_dice_dict["faces"]
	text = str(number) +"d"+ str(faces)
