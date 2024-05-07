extends ItemList

var QUANTITY = 0
var INDEX = 1

var contents:Dictionary
#This dictionary has the item ID as a key. The Value is an array where the first
#value is the quantity and the second value is its position. (as shown by the
#symbolic constants above)

func add_new_item(idx):
	var item_name = DataLoader.items[idx]["name"]
	if contents.has(idx):
		contents[idx][QUANTITY] += 1 #Increment quantity by 1
		#Update item text
		set_item_text(contents[idx][INDEX], item_name + " x" + \
			str(contents[idx][QUANTITY]))
	else:
		contents[idx] = [1, item_count]
		#Set the metadata to quantity = 1, index = number of items
		add_item(item_name)
