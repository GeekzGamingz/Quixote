extends Node2D
#------------------------------------------------------------------------------#
#Variables
#Bools
var intermission_over: bool = false
#Exported Variables
@export_enum(
	"intro",
	"I", "II", "III", "IV", "V", "VI", "VII",
	"intermission",
	"outro"
) var level: int
@export var quixote: CharacterBody2D
@export var sancho: CharacterBody2D
@export var notifier: Control
@export var intermission: Control
@export var grain_nodes: Array[Area2D] = []
#------------------------------------------------------------------------------#
#Functions
#Ready
func _ready() -> void:
	await get_tree().process_frame
	sancho.sancho_fsm.connect("target_acquired", level_switch)
#------------------------------------------------------------------------------#
#Custom Functions
func change_scene():
	var fade_player = intermission.get_node("FadePlayer")
	await get_tree().create_timer(3.0).timeout
	sancho.audio.stream = sancho.sancho_fsm.END
	sancho.audio.play()
	fade_player.play("fade_in")
	await fade_player.animation_finished
	level_reset()
	fade_player.play("fade_out")
	await fade_player.animation_finished
	sancho.is_ready = true
	intermission_over = true
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Level Switch
func level_switch(): level += 1
#Level Reset
func level_reset():
	quixote.collapsed = false
	quixote.windmill_sighted = false
	quixote.on_screen = false
	quixote.global_position = quixote.start_position
	quixote.drink_fountain()
	sancho.global_position = sancho.start_position
