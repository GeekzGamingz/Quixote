extends TextureButton
#------------------------------------------------------------------------------#
#Signals
signal yield_upgrade
signal flour_changed
#------------------------------------------------------------------------------#
#Variables
#Bools
var fully_upgraded: bool = false
#Integers
var upgrade: int = 1
#Exported Variables
@export var audio: AudioStreamPlayer2D
#------------------------------------------------------------------------------#
#Functions
func _process(_delta: float) -> void: check_button()
#Ready
func _ready() -> void: update_tooltip()
#------------------------------------------------------------------------------#
#Signaled Functions
#Upgrade Rotation Speed
func _on_button_up() -> void:
	if G.FLOUR >= upgrade:
		G.FLOUR -= upgrade
		upgrade += 1
		emit_signal("flour_changed")
		emit_signal("yield_upgrade")
	update_tooltip()
	audio.play()
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
		fully_upgraded = true
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Check Button
func check_button():
	if !fully_upgraded:
		if G.FLOUR >= upgrade: disabled = false
		else: disabled = true
	else: disabled = true
