extends PanelContainer
@onready var close_button = $Margins/VBoxContainer/CloseButton

var dragging = false

var drag_start_position = Vector2()

func _ready():
	close_button.connect("pressed", close_menu)

func _gui_input(event):
	# When the left mouse button is pressed, start dragging
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true
				# Record the start position
				drag_start_position = get_global_mouse_position() - position
			else:
				dragging = false

	# When the mouse is moving and we're dragging, update the position
	if event is InputEventMouseMotion and dragging:
		# Calculate the new position based on the mouse movement
		var mouse_offset = get_global_mouse_position() - drag_start_position
		position = mouse_offset

func close_menu():
	visible = false
