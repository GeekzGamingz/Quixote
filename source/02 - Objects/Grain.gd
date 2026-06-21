extends Area2D
#------------------------------------------------------------------------------#
#Constants
const STAGE_1 = preload("uid://ctic48dx0yb7x")
const STAGE_2 = preload("uid://niedp2jgqmqm")
const STAGE_3 = preload("uid://c03rqo2y4d8xs")
const STAGE_4 = preload("uid://jglarnyrgaoe")
const STAGE_5 = preload("uid://bjd68qvw5vkia")
#------------------------------------------------------------------------------#
#Signals
signal harvested
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
@export_enum(
	"Barren",
	"Seedling",
	"Tillering",
	"Stemling",
	"Heading",
	"Ripening"
) var stage: String = "Barren"
#OnReady Variables
@onready var sprite_base: Sprite2D = $SpriteBase
@onready var growth_timer: Timer = $GrowthTimer
@onready var plant_button: TextureButton = $Buttons/PlantButton
@onready var reap_button: TextureButton = $Buttons/ReapButton
#------------------------------------------------------------------------------#
#Functions
#Ready
func _ready() -> void: check_grain()
#------------------------------------------------------------------------------#
#Signaled Functions
#Reap Button
func _on_reap_button_up() -> void: harvest()
func _on_plant_button_up() -> void:
	if G.FLOUR > 0:
		stage = "Seedling"
		check_grain()
		G.FLOUR -= 1
#Growth Timer
func _on_growth_timeout() -> void:
	match(stage):
		"Seedling": stage = "Tillering"
		"Tillering": stage = "Stemling"
		"Stemling": stage = "Heading"
		"Heading":
			stage = "Ripening"
			print("[", name, "] Ready for Harvesting!")
		"Ripening": pass
	growth_timer.start()
	check_grain()
#------------------------------------------------------------------------------#
#Custom Functions
func check_grain():
	reap_button.set_deferred("visible", false)
	plant_button.set_deferred("visible", false)
	match(stage):
		"Barren":
			sprite_base.texture = null
			plant_button.set_deferred("visible", true)
		"Seedling": sprite_base.texture = STAGE_1
		"Tillering": sprite_base.texture = STAGE_2
		"Stemling": sprite_base.texture = STAGE_3
		"Heading": sprite_base.texture = STAGE_4
		"Ripening":
			sprite_base.texture = STAGE_5
			reap_button.set_deferred("visible", true)
#Harvest
func harvest():
	if stage == "Ripening":
		stage = "Seedling"
		emit_signal("harvested", 25)
		check_grain()
