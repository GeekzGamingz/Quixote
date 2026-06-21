extends Control
#------------------------------------------------------------------------------#
#Signals
signal collapse
#------------------------------------------------------------------------------#
#Variables
var flour_sacks: int = 0
#Exported Variables
@export var quixote: CharacterBody2D
@export var windmill: StaticBody2D
@export var grain_nodes: Array[Area2D] = []
#OnReady Variables
@onready var q_stamina: CenterContainer = $VBoxContainer/HBoxContainer/QuixoteContainer/Quixote
@onready var w_stamina: CenterContainer = $VBoxContainer/HBoxContainer/WindmillContainer/Windmill
@onready var g_reapings: CenterContainer = $VBoxContainer/HBoxContainer/VGrainContainer/GrainContainer
@onready var f_sack: CenterContainer = $VBoxContainer/HBoxContainer/FlourContainer
@onready var sacks_label: Label = $VBoxContainer/HBoxContainer/FlourContainer/SacksLabel
#------------------------------------------------------------------------------#
#Functions
#Ready
func _ready() -> void:
	quixote.connect("quixote_damage", quixote_damage)
	quixote.connect("windmill_damage", windmill_damage)
	windmill.connect("rotated", flour_gain)
	for grain in grain_nodes: grain.connect("harvested", reapings)
#------------------------------------------------------------------------------#
#Check Windmill Texture
func check_windmill():
	var over_value = w_stamina.progress_over.value
	if over_value >= 75: windmill.sprite_base.texture = windmill.BASE
	if over_value < 75 && over_value >= 50: windmill.sprite_base.texture = windmill.BASE_DAMAGE_1
	if over_value < 50 && over_value >= 25: windmill.sprite_base.texture = windmill.BASE_DAMAGE_2
	if over_value < 25: windmill.sprite_base.texture = windmill.BASE_DAMAGE_3
	check_stamina()
#Check Stamina progresss
func check_stamina():
	var stamina_array = [q_stamina, w_stamina]
	for stamina in stamina_array:
		if stamina.progress_over.value <= 0: emit_signal("collapse", stamina)
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Quixote Damage
func quixote_damage(damage_type, value):
	match(damage_type):
		"Geriatric": q_stamina.progress_damage(value)
	print("Quixote Took [(", value, ") ", damage_type, "] Damage!!")
	check_stamina()
#Windmill Damage
func windmill_damage(damage_type, value):
	match(damage_type):
		"Lance": w_stamina.progress_damage(value)
	print("Windmill Took [(", value, ") ", damage_type, "] Damage!!")
	check_windmill()
#Harvest Reapings
func reapings(value): g_reapings.progress_heal(value)
func flour_gain(value):
	if g_reapings.progress_over.value > 0:
		f_sack.progress_heal(value)
		g_reapings.progress_damage(value / 2)
	if f_sack.progress_under.value > 99:
		flour_sacks += 1
		sacks_label.text = str(flour_sacks)
		f_sack.progress_damage(100)
