extends TextureButton
#------------------------------------------------------------------------------#
#Signals
signal growth_upgrade
#------------------------------------------------------------------------------#
#Variables
#Integers
var upgrade: int = 1
#------------------------------------------------------------------------------#
#Functions
#Ready
func _ready() -> void: update_tooltip()
#------------------------------------------------------------------------------#
#Signaled Functions
#Upgrade Rotation Speed
func _on_button_up() -> void:
	if G.FLOUR >= upgrade + 1:
		G.FLOUR -= upgrade + 1
		upgrade += 1
		emit_signal("growth_upgrade")
	update_tooltip()
#------------------------------------------------------------------------------#
#Custom Functions
#Update Tooltip
func update_tooltip():
	if upgrade != 5:
		tooltip_text = "[Upgrade Growth]
						-1s Wait Time.
						Your green thumb isn't
						just because of that
						other crop you enjoy.
						{Costs %s Flour}" % str(upgrade + 1)
	else:
		set_deferred("disabled", true)
		tooltip_text = "[Upgrade Growth]
						Your green thumb isn't
						just because of that
						other crop you enjoy.
						{Fully Upgraded}"
