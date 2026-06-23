extends Control
#------------------------------------------------------------------------------#
#Constants
const PANEL = preload("uid://bxf0eqp2uio1d")
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var vbox: VBoxContainer = $HBoxContainer/VBoxContainer
#------------------------------------------------------------------------------#
#Custom Functions
func add_message(message, timeout):
	var panel_scene = PANEL.instantiate()
	vbox.add_child(panel_scene)
	panel_scene.load_message(message, timeout)
