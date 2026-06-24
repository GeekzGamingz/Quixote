extends TextureButton
#------------------------------------------------------------------------------#
const BUTTON1_PRESSED = preload("uid://dtb7tx5kopfcl")
const BUTTON1_UNPRESSED = preload("uid://da7kpu3d0frmv")
const BUTTON1_UNPRESSED_INACTIVE = preload("uid://bh7kcipt26k1y")
const BUTTON2_PRESSED = preload("uid://hb88ux6c6nue")
const BUTTON2_UNPRESSED = preload("uid://bpc6iwnuspq2d")
const BUTTON2_UNPRESSED_INACTIVE = preload("uid://bxd1ow7cf37c7")
const BUTTON3_PRESSED = preload("uid://bvh3t1hyd35gx")
const BUTTON3_UNPRESSED = preload("uid://devwivsd4kvj6")
const BUTTON3_UNPRESSED_INACTIVE = preload("uid://cl8j3ie4f2uor")
#------------------------------------------------------------------------------#
#Signals
signal flour_changed
signal check_arms
#------------------------------------------------------------------------------#
#Variables
#Bool
var fully_upgraded = false
#Integers
var upgrade: int = 1
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#------------------------------------------------------------------------------#
#Functions
func _process(_delta: float) -> void: check_button()
#Ready
func _ready() -> void: update_tooltip()
#------------------------------------------------------------------------------#
#Signaled Functions
#Upgrade Rotation Speed
func _on_button_up() -> void:
	var cost = (upgrade * 2) + 1
	if G.FLOUR >= cost:
		G.FLOUR -= cost
		upgrade += 1
		emit_signal("flour_changed")
	update_tooltip()
#------------------------------------------------------------------------------#
#Custom Functions
#Update Tooltip
func update_tooltip():
	var cost = str((upgrade * 2) + 1)
	match(upgrade):
		1:
			tooltip_text = "[Lengthen Arms]
							We can't currently reach the
							the Hidalgo from La Mancha in
							our current state. Have the
							human build us longer arms!
							{Costs %s Flour}" % cost
			texture_normal = BUTTON1_UNPRESSED
			texture_pressed = BUTTON1_PRESSED
			texture_disabled = BUTTON1_UNPRESSED_INACTIVE
		2:
			tooltip_text = "[Blade Arms]
							What beautiful engineering,
							but we can go further! Have the
							human install blades along our
							arms. That'll show the Don!
							{Costs %s Flour}" % cost
			texture_normal = BUTTON2_UNPRESSED
			texture_pressed = BUTTON2_PRESSED
			texture_disabled = BUTTON2_UNPRESSED_INACTIVE
			MAIN.NOTIFIER.add_message(
				"We, El Molino, have grown stronger...\nThe Don will try to rise to the challenge...", 10
			)
		3:
			tooltip_text = "[Electrify Arms]
							I have learned to store my
							kinetic energy. Have the human
							follow these blueprints...
							The results will be shocking.
							{Costs %s Flour}" % cost
			texture_normal = BUTTON3_UNPRESSED
			texture_pressed = BUTTON3_PRESSED
			texture_disabled = BUTTON3_UNPRESSED_INACTIVE
			MAIN.NOTIFIER.add_message(
				"We, El Molino, have grown stronger...\nThe Don will try to rise to the challenge...", 10
			)
		4:
			tooltip_text = "[Upgrade Arms]
							This isn't even my final form...
							{Fully Upgraded}"
			texture_normal = BUTTON3_UNPRESSED
			texture_pressed = BUTTON3_PRESSED
			texture_disabled = BUTTON3_UNPRESSED_INACTIVE
			fully_upgraded = true
			MAIN.NOTIFIER.add_message(
				"This isn't even my final form!\n Quixote shall perish in the morrow!!", 10
			)
	emit_signal("check_arms", upgrade)
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Check Button
func check_button():
	var cost = (upgrade * 2) + 1
	if !fully_upgraded:
		if G.FLOUR >= cost: disabled = false
		else: disabled = true
	else: disabled = true
