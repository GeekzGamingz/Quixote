extends TextureButton
#------------------------------------------------------------------------------#
#Signals
signal rescue
#------------------------------------------------------------------------------#
#Variables
var rescued = false
#Exported Variables
@export var cost: int = 5
@export var audio: AudioStreamPlayer2D
#------------------------------------------------------------------------------#
#Functions
func _ready() -> void: update_tooltip()
func _process(_delta: float) -> void: check_button()
#------------------------------------------------------------------------------#
#Signaled Functions
#Rescue Pubby
func _on_button_up() -> void:
	if !rescued && G.FLOUR > cost:
		G.FLOUR -= cost
		emit_signal("rescue")
		rescued = true
	audio.play()
	update_tooltip()
#------------------------------------------------------------------------------#
#Custom Functions
#Check Button
func check_button():
	if G.FLOUR > cost: disabled = false
	else: disabled = true
	if rescued: disabled = true
#Update Tooltip
func update_tooltip():
	if !rescued:
		tooltip_text = "[Rescue Pubby]
						They say they're 'Man's
						Best Friend'. At the very
						least it will drown out that
						incessant music...
						{Costs %s Flour}" % str(cost)
	else:
		set_deferred("disabled", true)
		tooltip_text = "[Pubby Rescued]
						The beast might be more
						useful than I had originally
						anticipated...
						{Fully Upgraded}"
