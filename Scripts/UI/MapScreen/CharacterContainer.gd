extends PanelContainer

@onready var skills_container = $"../SkillsContainer"

func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			skills_container.visible = true
