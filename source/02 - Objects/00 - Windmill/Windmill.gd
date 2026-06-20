extends StaticBody2D
#------------------------------------------------------------------------------#
#Signals
signal spin
#------------------------------------------------------------------------------#
#Variable
@export_range(2, 20, 1, "prefer_slider") var wind_speed: int
#OnReady Variables
@onready var pin: PinJoint2D = $PinJoint2D
#------------------------------------------------------------------------------#
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
