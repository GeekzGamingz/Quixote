extends StaticBody2D
#------------------------------------------------------------------------------#
#Signals
signal spin
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
#------------------------------------------------------------------------------#
#Ready
func _ready() -> void:
	await get_tree().process_frame
	MAIN.PROGRESS.connect("collapse", collapse)
#Signaled Functions
#Mouse Enter/Exit
func _on_axis_mouse_entered() -> void: focus_spin(true)
func _on_axis_mouse_exited() -> void: focus_spin(false)
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
func collapse(origin):
	if !collapsed:
		match(origin.name):
			"Quixote": print("<Farmer Random Animation>")
			"Windmill":
				collapsed = true
				pin.node_b = ""
				$CollisionPolygon2D.set_deferred("disabled", true)
		print("#---[", self.name, "] Witnessed [", origin.name, "]'s Collapse!---#")
