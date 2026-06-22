extends TextureButton
#------------------------------------------------------------------------------#
#Signals
signal erect_fence
#------------------------------------------------------------------------------#
#Variables
#Bools
var built: bool = false
#Integers
var cost: int = 3
#------------------------------------------------------------------------------#
#Functions
#Ready
func _ready() -> void: update_tooltip()
#------------------------------------------------------------------------------#
#Signaled Functions
#Upgrade Rotation Speed
func _on_button_up() -> void:
	if G.FLOUR >= cost:
		G.FLOUR -= cost
		built = true
		emit_signal("erect_fence")
	update_tooltip()
#------------------------------------------------------------------------------#
#Custom Functions
#Update Tooltip
func update_tooltip():
	if !built:
		tooltip_text = "[Build Fence]
						Have the human build us
						a fence to keep out any
						pesky trespassers.
						{Costs %s Flour}" % str(cost)
	else:
		set_deferred("disabled", true)
		tooltip_text = "[Repair Fence]
						Repair the Fence, Human!
						It helped; Even, but for a
						moment.
						{Costs %s Flour}" % str(cost)
