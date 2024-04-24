extends Button

@onready var inventory_container = $"../../../../../../../InventoryContainer"

func _on_pressed():
	inventory_container.visible = true
