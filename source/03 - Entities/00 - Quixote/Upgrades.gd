extends Node2D
#------------------------------------------------------------------------------#
#Constants
const DON_LVL1_SHEET = preload("uid://dht0a7yqoyhnt")
const DON_LVL2_SHEET = preload("uid://cah4c7qh11tjs")
const DON_LVL3_SHEET = preload("uid://bqmvf8wcftwlu")
const DON_LVL4_SHEET = preload("uid://7uqppha7o2cm")
const DON_LVL5_SHEET = preload("uid://0l3vou26yo1x")
const DON_LVL6_SHEET = preload("uid://ctgvopm04k1d2")
const DON_LVL7_SHEET = preload("uid://ku4qjlc2gvkr")
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#Local Nodes
@onready var quixote: CharacterBody2D = $".."
#------------------------------------------------------------------------------#
#Custom Functions
func check_upgrade(level):
	match(level):
		0: quixote.sprite_base.texture = DON_LVL1_SHEET
		1: quixote.sprite_base.texture = DON_LVL2_SHEET
		2: quixote.sprite_base.texture = DON_LVL3_SHEET
		3: quixote.sprite_base.texture = DON_LVL4_SHEET
		4: quixote.sprite_base.texture = DON_LVL5_SHEET
		5: quixote.sprite_base.texture = DON_LVL6_SHEET
		6: quixote.sprite_base.texture = DON_LVL7_SHEET
	quixote.lance.target_position.x = (level * 4) + 12
	quixote.horse_speed = (level * 3) + 1
	quixote.starting_speed = quixote.horse_speed
	quixote.geriatric_damage_base = 12 - (level)
	quixote.geriatric_damage_max = 22 - (level * 2)
	quixote.geriatric_ticks = 9 + (level)
