extends TextureButton
#------------------------------------------------------------------------------#
#Signals
signal repair
signal flour_changed
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
@export var audio: AudioStreamPlayer2D
#------------------------------------------------------------------------------#
#Functions
func _process(_delta: float) -> void: check_button()
#------------------------------------------------------------------------------#
#Signaled Functions
#Repair Windmill
func _on_button_up() -> void:
	var cost = 1
	if G.FLOUR > 0:
		emit_signal("repair", 50)
		G.FLOUR -= cost
		emit_signal("flour_changed")
	audio.play()
#------------------------------------------------------------------------------#
#Custom Functions
#Check Button
func check_button():
	if G.FLOUR > 0: disabled = false
	else: disabled = true
