extends StaticBody2D
#------------------------------------------------------------------------------#
#Constants
const BASE = preload("uid://b5qatte40smgt")
const BASE_DAMAGE_1 = preload("uid://ci88xju3wg772")
const BASE_DAMAGE_2 = preload("uid://bdbq5bpsy78jt")
const BASE_DAMAGE_3 = preload("uid://dtknhtk3iy6fg")
#------------------------------------------------------------------------------#
#Signals
signal spin
signal rotated
#------------------------------------------------------------------------------#
#Variable
#Bools
var collapsed: bool = false
#Integers
@export_range(2, 20, 1, "prefer_slider") var wind_speed: int
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#Local Nodes
@onready var pin: PinJoint2D = $PinJoint2D
@onready var sprite_base: Sprite2D = $SpriteBase
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
func _on_mill_area_exited(_area: Area2D) -> void: emit_signal("rotated", 15)
#------------------------------------------------------------------------------#
#Custom Functions
func focus_spin(focused):
	if focused:
		print("#---Focused Spinning---#")
		pin.motor_target_velocity = wind_speed
		emit_signal("spin", focused, wind_speed)
	else:
		pin.motor_target_velocity = 1
		emit_signal("spin", focused, 2)
		print("#---Idle Spinning---#")
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
		print("#---[", self.name, "] Witnessed [", origin.name, "]'s Collapse!---#")
#Upgrade Rotation
func rotation_upgrade(): if wind_speed < 20: wind_speed += 5
