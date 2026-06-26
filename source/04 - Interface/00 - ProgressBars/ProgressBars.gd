extends Control
#------------------------------------------------------------------------------#
#Signals
signal collapse
signal flour_changed
signal fence_broken
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
@export var quixote: CharacterBody2D
@export var windmill: StaticBody2D
@export var fence: StaticBody2D
@export var grain_nodes: Array[Area2D] = []
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#Local Nodes
@onready var q_stamina: CenterContainer = $VBoxContainer/HBoxContainer/QuixoteContainer/Quixote
@onready var w_stamina: CenterContainer = $VBoxContainer/HBoxContainer/WindmillContainer/Windmill
@onready var f_stamina: CenterContainer = $VBoxContainer/HBoxContainer/VFenceContainer/FenceContainer
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
	quixote.connect("quixote_heal", quixote_heal)
	quixote.connect("windmill_damage", windmill_damage)
	quixote.connect("fence_damage", fence_damage)
	windmill.connect("rotated", flour_gain)
	windmill.connect("windmill_damage", windmill_damage)
	fence.connect("fence_repair", fence_repair)
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
#Quixote
#Quixote Damage
func quixote_damage(damage_type, value): if !quixote.collapsed:
	match(damage_type): #Tracking for Special Events
		"Geriatric": q_stamina.progress_damage(value)
		"Electric": q_stamina.progress_damage(value)
		"Bludgeoning": q_stamina.progress_damage(value)
		"Slashing": q_stamina.progress_damage(value)
		"Fork": q_stamina.progress_damage(value)
		"Molina": q_stamina.progress_damage(value)
	var notifier = MAIN.NOTIFIER
	if notifier.vbox.get_child_count() < 5:
		if value > 10: notifier.add_message(str("Quixote Took Great ", damage_type, " Damage!!"), 3)
		elif value > 30: notifier.add_message(str("Quixote Took Massive ", damage_type, " Damage!!"), 3)
		else: notifier.add_message(str("Quixote Took ", damage_type, " Damage!"), 3)
	check_stamina()
#Quixote Heal
func quixote_heal(value): q_stamina.progress_heal(value)
#Windmill
#Windmill Damage
func windmill_damage(damage_type, value): if !windmill.collapsed:
	match(damage_type):
		"Lance": w_stamina.progress_damage(value)
		"Minstrel": w_stamina.progress_damage(value)
	check_windmill()
#Windmill Heal
func windmill_heal(value):
	w_stamina.progress_heal(value)
	check_windmill()
#Fence
#Fence Damage
func fence_damage(damage_type, value):
	match(damage_type):
		"Lance": f_stamina.progress_damage(value)
	if f_stamina.progress_over.value <= 0:
		fence.state = "Broken"
		fence.check_fence()
		emit_signal("fence_broken")
		MAIN.NOTIFIER.add_message(str("Fence was Destroyed by ", damage_type, " Damage!!"), 3)
#Fence Repair
func fence_repair(value):
	f_stamina.progress_heal(value)
	fence.check_fence()
#Harvest Reapings
func reapings(value): g_reapings.progress_heal(value)
func flour_gain(value):
	if g_reapings.progress_over.value > 0:
		f_sack.progress_heal(value)
		g_reapings.progress_damage(value / 2)
	if f_sack.progress_over.value >= 100:
		G.FLOUR += 1
		f_sack.progress_damage(100)
		MAIN.NOTIFIER.add_message(str("Finished Milling a Sack of Flour!"), 3)
	emit_signal("flour_changed")
