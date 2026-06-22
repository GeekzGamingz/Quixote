extends TextureButton
#------------------------------------------------------------------------------#
#Signals
signal yield_upgrade
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
	if G.FLOUR >= upgrade:
		G.FLOUR -= upgrade
		upgrade += 1
		emit_signal("yield_upgrade")
	update_tooltip()
#------------------------------------------------------------------------------#
#Custom Functions
#Update Tooltip
func update_tooltip():
	if upgrade != 3:
		tooltip_text = "[Upgrade Yield]
						Due to the Don's incessant
						shenanigans, you have
						learned to make your wheat
						stretch, yielding more flour!
						{Costs %s Flour}" % str(upgrade)
	else:
		set_deferred("disabled", true)
		tooltip_text = "[Upgrade Yield]
						Due to the Don's incessant
						shenanigans, you have
						learned to make your wheat
						stretch, yielding more flour!
						{Fully Upgraded}"
