extends Node2D
#------------------------------------------------------------------------------#
#Constants
const GAME_OVER = preload("uid://kjlntl5mrham")
const GAME_OVER_WIN = preload("uid://ci4u8gvut150q")
const GAME_OVER_LOSS = preload("uid://b5c2dl0dvlfkw")
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
@export var windmill: StaticBody2D
@export var quixote: CharacterBody2D
@export var sancho: CharacterBody2D
@export var notifier: Control
@export var intermission: Control
@export var splash_canvas: CanvasLayer
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
	if level == 3:
		sancho.participating = true
		sancho.sprite_base.texture = sancho.SANCHO_UPGRADED
	level_reset()
	fade_player.play("fade_out")
	await fade_player.animation_finished
	sancho.is_ready = true
	intermission_over = true
#Game Over
func game_over(success):
	var over_scene = GAME_OVER.instantiate()
	await get_tree().create_timer(3).timeout
	splash_canvas.add_child(over_scene)
	match(success):
		"Lost": over_scene.bg_rect.texture = GAME_OVER_LOSS 
		"Won":
			over_scene.bg_rect.texture = GAME_OVER_WIN
			over_scene.sprite_arms.set_deferred("visible", true)
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
