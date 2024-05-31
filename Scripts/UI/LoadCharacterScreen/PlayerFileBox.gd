extends PanelContainer

@onready var name_label = %NameLabel

@onready var race_label = %RaceLabel
@onready var subrace_label = %SubraceLabel
@onready var subclass_label = %SubclassLabel
@onready var class_label = %ClassLabel

@onready var xp_bar = %XPBar
@onready var hp_bar = %HPBar

@onready var stre = %Str
@onready var dex = %Dex
@onready var con = %Con
@onready var intel = %Int
@onready var wis = %Wis
@onready var cha = %Cha

var filepath:String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(data):
	name_label.text = data["name"]
	race_label.text = data["race"]
	subrace_label.text = data["subrace"]
	class_label.text = data["classes"][0][0]
	print(data["subclasses"])
	subclass_label.text = data["subclasses"][0][1]
	
	stre.text = str(data["ability_scores"]["str"])
	dex.text = str(data["ability_scores"]["dex"])
	con.text = str(data["ability_scores"]["con"])
	intel.text = str(data["ability_scores"]["int"])
	wis.text = str(data["ability_scores"]["wis"])
	cha.text = str(data["ability_scores"]["cha"])
	
	hp_bar.value = data["current_health"]
	hp_bar.max_value = data["max_health"]
