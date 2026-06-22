extends Control
#------------------------------------------------------------------------------#
#Signals
signal collapse
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
@export var quixote: CharacterBody2D
@export var windmill: StaticBody2D
@export var grain_nodes: Array[Area2D] = []
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#Local Nodes
@onready var q_stamina: CenterContainer = $VBoxContainer/HBoxContainer/QuixoteContainer/Quixote
@onready var w_stamina: CenterContainer = $VBoxContainer/HBoxContainer/WindmillContainer/Windmill
@onready var g_reapings: CenterContainer = $VBoxContainer/HBoxContainer/VGrainContainer/GrainContainer
@onready var f_sack: CenterContainer = $VBoxContainer/HBoxContainer/FlourContainer
@onready var sacks_label: Label = $VBoxContainer/HBoxContainer/FlourContainer/SacksLabel
#------------------------------------------------------------------------------#
#Functions
#Process
func _process(_delta: float) -> void: sacks_label.text = str(G.FLOUR)
#Ready
func _ready() -> void:
	quixote.connect("quixote_damage", quixote_damage)
	quixote.connect("windmill_damage", windmill_damage)
	windmill.connect("rotated", flour_gain)
	for grain in grain_nodes: grain.connect("harvested", reapings)
	await get_tree().process_frame
	MAIN.SHOP.repair_button.connect("repair", windmill_heal)
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
#Windmill Heal
func windmill_heal():
	w_stamina.progress_heal(50)
	check_windmill()
#Harvest Reapings
func reapings(value): g_reapings.progress_heal(value)
func flour_gain(value):
	if g_reapings.progress_over.value > 0:
		f_sack.progress_heal(value)
		g_reapings.progress_damage(value / 2)
	if f_sack.progress_over.value > 99:
		G.FLOUR += 1
		f_sack.progress_damage(100)
