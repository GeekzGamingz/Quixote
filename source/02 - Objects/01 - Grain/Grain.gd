extends Area2D
#------------------------------------------------------------------------------#
#Constants
const STATE_1 = preload("uid://ctic48dx0yb7x")
const STATE_2 = preload("uid://niedp2jgqmqm")
const STATE_3 = preload("uid://c03rqo2y4d8xs")
const STATE_4 = preload("uid://jglarnyrgaoe")
const STATE_5 = preload("uid://bjd68qvw5vkia")
#------------------------------------------------------------------------------#
#Signals
signal harvested
signal flour_changed
#------------------------------------------------------------------------------#
#Variables
var crop_yield: int = 10
#Exported Variables
@export_enum(
	"Barren",
	"Seedling",
	"Tillering",
	"Stemling",
	"Heading",
	"Ripening"
) var state: String = "Barren"
#OnReady Variables
#Main Variables
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#Local Variables
@onready var sprite_base: Sprite2D = $SpriteBase
@onready var growth_timer: Timer = $GrowthTimer
@onready var plant_button: TextureButton = $Buttons/PlantButton
@onready var reap_button: TextureButton = $Buttons/ReapButton
@onready var audio_grain: AudioStreamPlayer2D = $AudioPlayers/GrainAudio
@onready var audio_button: AudioStreamPlayer2D = $AudioPlayers/ButtonAudio
@onready var audio_seed: AudioStreamPlayer2D = $AudioPlayers/SeedAudio
#------------------------------------------------------------------------------#
#Functions
func _process(_delta: float) -> void: check_button()
#Ready
func _ready() -> void:
	check_grain()
	await get_tree().process_frame
	MAIN.PROGRESS.connect("flour_changed", check_grain)
	MAIN.SHOP.growth_button.connect("growth_upgrade", growth_upgrade)
	MAIN.SHOP.yield_button.connect("yield_upgrade", yield_upgrade)
#------------------------------------------------------------------------------#
#Signaled Functions
#Reap Button
func _on_reap_button_up() -> void:
	harvest()
	audio_button.play()
func _on_plant_button_up() -> void:
	if G.FLOUR > 0:
		state = "Seedling"
		G.FLOUR -= 1
		check_grain()
		emit_signal("flour_changed")
	audio_button.play()
	audio_seed.play()
#Growth Timer
func _on_growth_timeout() -> void:
	match(state):
		"Seedling": state = "Tillering"
		"Tillering": state = "Stemling"
		"Stemling": state = "Heading"
		"Heading": state = "Ripening"
		"Ripening": pass
	growth_timer.start()
	check_grain()
#------------------------------------------------------------------------------#
#Check Button
func check_button():
	if G.FLOUR > 0: plant_button.disabled = false
	else: plant_button.disabled = true
#Custom Functions
func check_grain():
	reap_button.set_deferred("visible", false)
	plant_button.set_deferred("visible", false)
	match(state):
		"Barren":
			sprite_base.texture = null
			plant_button.set_deferred("visible", true)
		"Seedling": sprite_base.texture = STATE_1
		"Tillering": sprite_base.texture = STATE_2
		"Stemling": sprite_base.texture = STATE_3
		"Heading": sprite_base.texture = STATE_4
		"Ripening":
			sprite_base.texture = STATE_5
			reap_button.set_deferred("visible", true)
#Harvest
func harvest():
	if state == "Ripening":
		state = "Seedling"
		emit_signal("flour_changed")
		emit_signal("harvested", crop_yield)
		audio_grain.play()
		check_grain()
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Upgrade Growth Speed
func growth_upgrade(): growth_timer.wait_time -= 1
#Upgrade Crop Yield
func yield_upgrade(): crop_yield += 10
