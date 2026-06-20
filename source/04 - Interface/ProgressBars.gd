extends Control
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
@export var quixote: CharacterBody2D
@export var windmill: StaticBody2D
#OnReady Variables
@onready var q_stamina: CenterContainer = $VBoxContainer/HBoxContainer/VBoxContainer/Quixote
@onready var w_stamina: CenterContainer = $VBoxContainer/HBoxContainer/VBoxContainer2/Windmill
#------------------------------------------------------------------------------#
#Functions
#Ready
func _ready() -> void: quixote.connect("quixote_damage", quixote_damage)
#------------------------------------------------------------------------------#
#Custom Signaled Functions
func quixote_damage(damage_type, value):
	match(damage_type):
		"Geriatric": q_stamina.stamina_damage(value)
	print("Quixote Took [(", value, ") ", damage_type, "] Damage!!")
	
