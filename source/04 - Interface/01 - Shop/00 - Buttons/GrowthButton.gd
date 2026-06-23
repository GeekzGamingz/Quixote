extends TextureButton
#------------------------------------------------------------------------------#
#Signals
signal growth_upgrade
signal flour_changed
#------------------------------------------------------------------------------#
#Variables
#Integers
var upgrade: int = 1
#------------------------------------------------------------------------------#
#Functions
func _process(_delta: float) -> void: check_button()
#Ready
func _ready() -> void: update_tooltip()
#------------------------------------------------------------------------------#
#Signaled Functions
#Upgrade Rotation Speed
func _on_button_up() -> void:
	if G.FLOUR >= upgrade + 1:
		G.FLOUR -= upgrade + 1
		upgrade += 1
		emit_signal("flour_changed")
		emit_signal("growth_upgrade")
	update_tooltip()
#------------------------------------------------------------------------------#
#Custom Functions
#Update Tooltip
func update_tooltip():
	if upgrade < 5:
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
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Check Button
func check_button():
	if G.FLOUR >= upgrade + 1: disabled = false
	else: disabled = true
