extends Button

@onready var character_basics_screen = %CharacterBasicsScreen
@onready var character_features_screen = %CharacterFeaturesScreen
@onready var backpack_creation_screen = %BackpackCreationScreen

func _on_pressed():
	character_basics_screen.visible = false
	character_features_screen.visible = true
	backpack_creation_screen.visible = false
