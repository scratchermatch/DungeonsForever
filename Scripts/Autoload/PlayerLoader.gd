extends Node

var character_name:String
var classes:Dictionary #Contains Class: level
var race:String
var num_dice:int #the 4 in 4d8
var num_faces:int #the 8 in 4d8
var hit_points:int
var xp:int
var ability_scores:Dictionary
var background:String
var alignment:int
var skills:Dictionary #Athletics: (P or M)
var proficiency_bonus
var speed:Dictionary #Walking: 30, Flying: 30, etc.

func load_character():
	pass

func save_character():
	hard_pass()

func hard_pass():
	pass
	pass
