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
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#Local Nodes
@onready var windmill: StaticBody2D = $".."
#------------------------------------------------------------------------------#
#Functions
#Ready
func _ready() -> void:
	await get_tree().process_frame
	MAIN.SHOP.upgrade_button.connect("check_arms", check_arms)
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
