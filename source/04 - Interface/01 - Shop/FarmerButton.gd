extends TextureButton
#------------------------------------------------------------------------------#
#Signals
signal anger
#------------------------------------------------------------------------------#
#Variables
var angered = false
#Exported Variables
@export var cost: int = 3
@export var audio: AudioStreamPlayer2D
#------------------------------------------------------------------------------#
#Functions
func _ready() -> void: update_tooltip()
func _process(_delta: float) -> void: check_button()
#------------------------------------------------------------------------------#
#Signaled Functions
#Rescue Pubby
func _on_button_up() -> void:
	if !angered && G.FLOUR >= cost:
		G.FLOUR -= cost
		emit_signal("anger")
		angered = true
	audio.play()
	update_tooltip()
#------------------------------------------------------------------------------#
#Custom Functions
#Check Button
func check_button():
	if G.FLOUR >= cost: disabled = false
	else: disabled = true
	if angered: disabled = true
#Update Tooltip
func update_tooltip():
	if !angered:
		tooltip_text = "[Rally Farmer]
						Instill our human with
						the ferocity of EL MOLINO...
						(Now Including a Barrel
						of Infinite Pitchforks!!)
						{Costs %s Flour}" % str(cost)
	else:
		set_deferred("disabled", true)
		tooltip_text = "[Farmer ANGY]
						Feel the hate inside you...
						{Fully Upgraded}"
