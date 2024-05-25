extends ItemList

@onready var inventory = %Inventory
@onready var quantity_line_edit = %QuantityLineEdit

var last_selected = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	for item in DataLoader.items:
		add_item(item["name"])

func _on_add_item_pressed():
	if last_selected != -1:
		inventory.add_new_item(last_selected)
	else:
		print("Nothing selected!")

func _on_item_selected(index):
	last_selected = index


func _on_quantity_button_pressed():
	for i in range(int(quantity_line_edit.text)):
		inventory.add_new_item(last_selected)
