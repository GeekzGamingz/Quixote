extends TextureButton
#------------------------------------------------------------------------------#
#Signals
signal repair
#------------------------------------------------------------------------------#
#Repair Windmill
func _on_button_up() -> void:
	var cost = 1
	if G.FLOUR > 0:
		emit_signal("repair")
		G.FLOUR -= cost
