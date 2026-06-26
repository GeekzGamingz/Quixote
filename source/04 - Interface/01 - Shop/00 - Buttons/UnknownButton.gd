extends TextureButton
#------------------------------------------------------------------------------#
#Signals
signal final_form
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
@export var unlocked: bool = false
@export var audio: AudioStreamPlayer2D
#------------------------------------------------------------------------------#
#Functions
func _process(_delta: float) -> void: check_button()
#------------------------------------------------------------------------------#
#Signaled Functions
#Repair Windmill
func _on_button_up() -> void:
	emit_signal("final_form")
	audio.play()
#------------------------------------------------------------------------------#
#Custom Functions
#Check Button
func check_button():
	if unlocked: disabled = false
	else: disabled = true
