extends Button
@onready var multiclass_spacer = %MulticlassSpacer

func _on_level_value_changed(value):
	if value > 1:
		visible = true
		multiclass_spacer.visible = false
	else:
		visible = false
		multiclass_spacer.visible = true
