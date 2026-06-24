extends StaticBody2D
#------------------------------------------------------------------------------#
#Constants
const BASE = preload("uid://b5qatte40smgt")
const BASE_DAMAGE_1 = preload("uid://ci88xju3wg772")
const BASE_DAMAGE_2 = preload("uid://bdbq5bpsy78jt")
const BASE_DAMAGE_3 = preload("uid://dtknhtk3iy6fg")
const LIGHTNING_BALL = preload("uid://diygev468lgg3")
#------------------------------------------------------------------------------#
#Signals
signal spin
signal rotated
#------------------------------------------------------------------------------#
#Variable
#Bools
var collapsed: bool = false
#Exported Variables
#Integers
@export_range(2, 20, 1, "prefer_slider") var wind_speed: int
#Arrays
@export var arms_array: Array[Area2D] = []
#Nodes
@export var quixote: CharacterBody2D
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#Local Nodes
@onready var pin: PinJoint2D = $PinJoint2D
@onready var upgrades: Node2D = $Upgrades
@onready var sprite_base: Sprite2D = $SpriteBase
@onready var sprite_spire: Sprite2D = $SpriteSpire
@onready var launch_marker: Marker2D = $SpriteSpire/Marker2D
@onready var arm_player: AnimationPlayer = $AnimationPlayers/ArmPlayer
#------------------------------------------------------------------------------#
#Ready
func _ready() -> void:
	await get_tree().process_frame
	MAIN.PROGRESS.connect("collapse", collapse)
	MAIN.SHOP.rotation_button.connect("rotation_upgrade", rotation_upgrade)
#Signaled Functions
#Mouse Enter/Exit
func _on_axis_mouse_entered() -> void: focus_spin(true)
func _on_axis_mouse_exited() -> void: focus_spin(false)
#Rotation Detection
func _on_mill_area_exited(_area: Area2D) -> void:
	if upgrades.arms == "Electrified": #if quixote.on_screen:
		launch_lightning(quixote)
	emit_signal("rotated", 15)
#------------------------------------------------------------------------------#
#Custom Functions
#Focus Spin
func focus_spin(focused):
	if focused:
		pin.motor_target_velocity = wind_speed
		emit_signal("spin", focused, wind_speed)
	else:
		pin.motor_target_velocity = 1
		emit_signal("spin", focused, 2)
#Launch Lightning
func launch_lightning(_target):
	var lightning_scene = LIGHTNING_BALL.instantiate()
	MAIN.ORPHANAGE.call_deferred("add_child", lightning_scene)
	lightning_scene.global_position = launch_marker.global_position
	lightning_scene.launch(quixote)
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Collapse
func collapse(origin):
	if !collapsed:
		match(origin.name):
			"Quixote": print("<Farmer Random Animation>")
			"Windmill":
				collapsed = true
				pin.node_b = ""
#Upgrade Rotation
func rotation_upgrade(): if wind_speed < 20: wind_speed += 5
