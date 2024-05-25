extends SpinBox

@onready var hit_dice = %HitDice

func _on_value_changed(value):
	PlayerLoader.data["max_health"] = value
	PlayerLoader.data["current_health"] = value

func _on_hit_dice_ready():
	value = hit_dice.faces
