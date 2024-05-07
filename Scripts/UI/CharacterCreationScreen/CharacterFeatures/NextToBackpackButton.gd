extends Button

@onready var character_features_screen = %CharacterFeaturesScreen
@onready var backpack_creation_screen = %BackpackCreationScreen
@onready var character_basics_screen = %CharacterBasicsScreen

func _on_pressed():
	character_features_screen.visible = false
	backpack_creation_screen.visible = true
	character_basics_screen.visible = false
