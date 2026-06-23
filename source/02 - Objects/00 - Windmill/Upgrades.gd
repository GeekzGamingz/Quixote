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
@onready var windmill: StaticBody2D = $".."
#------------------------------------------------------------------------------#
#Functions
#Ready
func _ready() -> void:
	await get_tree().process_frame
	check_arms()
#------------------------------------------------------------------------------#
#Custom Functions
func check_arms():
	for arm in windmill.arms_array:
		arm.get_node("CollisionShape2D").set_deferred("disabled", false)
	match(arms):
		"Default":
			windmill.arm_player.play("default")
			for arm in windmill.arms_array:
				arm.get_node("CollisionShape2D").set_deferred("disabled", true)
		"Lengthened": windmill.arm_player.play("lengthened")
		"Bladed": windmill.arm_player.play("bladed")
		"Electrified":
			windmill.arm_player.play("electrified_inert")
			await windmill.arm_player.animation_finished
			windmill.arm_player.play("electrified_loop")
