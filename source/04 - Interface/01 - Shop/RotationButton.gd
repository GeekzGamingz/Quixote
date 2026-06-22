extends TextureButton
#------------------------------------------------------------------------------#
#Signals
signal rotation_upgrade
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
	if G.FLOUR >= upgrade * 3:
		G.FLOUR -= upgrade * 3
		upgrade += 1
		emit_signal("rotation_upgrade")
		update_tooltip()
#------------------------------------------------------------------------------#
#Custom Functions
#Update Tooltip
func update_tooltip():
	if upgrade != 3:
		tooltip_text = "[Upgrade Rotation]
						Increase the windmill's
						rotation speed when hovering,
						processing flour quicker
						and other fun results!
						{Costs %s Flour}" % str(upgrade * 3)
	else:
		set_deferred("disabled", true)
		tooltip_text = "[Upgrade Rotation]
						Increase the windmill's
						rotation speed when hovering,
						processing flour quicker
						and other fun results!
						{Fully Upgraded}"
