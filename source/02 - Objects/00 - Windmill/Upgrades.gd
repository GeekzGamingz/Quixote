extends Node2D
#------------------------------------------------------------------------------#
#Constants
const ARMS_BASIC = preload("uid://qb3ntumuildp")
const ARMS_LONG = preload("uid://byaher2pu6kx2")
const ARMS_BLADED = preload("uid://cc32a2fj0a4es")
const ARMS_ELECTRIFIED_SHEET = preload("uid://vtlp80fvae5y")
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
@export_enum(
	"Default",
	"Lengthened",
	"Bladed",
	"Electrified"
) var arms: String = "Default"
@export var sprite_array: Array[Node2D] = []
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#Local Nodes
@onready var windmill: StaticBody2D = $".."
@onready var upgrade_final: CharacterBody2D = $FinalForm
@onready var final_player = upgrade_final.get_node("AnimationPlayer")
#------------------------------------------------------------------------------#
#Functions
#Ready
func _ready() -> void:
	await get_tree().process_frame
	MAIN.SHOP.upgrade_button.connect("check_arms", check_arms)
	MAIN.SHOP.unknown_button.connect("final_form", final_form)
	check_arms(1)
#------------------------------------------------------------------------------#
#Custom Functions
func check_arms(upgrade):
	windmill.sprite_spire.set_deferred("visible", false)
	for arm in windmill.arms_array:
		arm.get_node("CollisionShape2D").set_deferred("disabled", false)
	match(upgrade):
		1: arms = arms
		2: arms = "Lengthened"
		3: arms = "Bladed"
		4: arms = "Electrified"
	match(arms):
		"Default":
			windmill.arm_player.play("default")
			for arm in windmill.arms_array:
				arm.get_node("CollisionShape2D").set_deferred("disabled", true)
		"Lengthened": windmill.arm_player.play("lengthened")
		"Bladed": windmill.arm_player.play("bladed")
		"Electrified":
			windmill.sprite_spire.set_deferred("visible", true)
			windmill.arm_player.play("electrified_inert")
			await windmill.arm_player.animation_finished
			windmill.arm_player.play("electrified_loop")
#------------------------------------------------------------------------------#
#Final Form
func final_form():
	#Collapse Quixote / Break Fence
	windmill.quixote.death = true
	windmill.fence.state = "Broken"
	windmill.fence.check_fence()
	MAIN.NOTIFIER.add_message("YOU'VE ACTIVATED MY FINAL FORM!!", 5)
	#Hide/Show Forms
	for sprite in sprite_array: sprite.set_deferred("visible", false)
	upgrade_final.set_deferred("visible", true)
	#Activate Animations
	final_player.play("rise")
	await final_player.animation_finished
	MAIN.NOTIFIER.add_message("Time for thine tale to come to a halt...", 3)
	final_player.play("steppies")
	#Move Molina
	var destination = windmill.quixote.global_position.x
	var tween = create_tween()
	tween.tween_property(upgrade_final, "global_position:x", destination, 10)
	tween.play()
	tween.tween_callback(continue_animations)
#Continue Animiations
func continue_animations():
	MAIN.NOTIFIER.add_message("Goodbye... Giant Slayer.", 3)
	windmill.quixote.emit_signal("quixote_damage", "Molina", 100)
	final_player.play("settle")
	await final_player.animation_finished
	final_player.play("unicorn_emerge")
	await final_player.animation_finished
	final_player.play("unicorn_idle")
