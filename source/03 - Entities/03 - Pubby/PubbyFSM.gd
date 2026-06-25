#Inherits StateMachine Code
extends StateMachine
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var pubby: Node2D = $".."
@onready var state_label: Label = $"../Outputs/StateOutput"
#------------------------------------------------------------------------------#
#Ready Method
func _ready() -> void:
	#Add States
	state_add("kenneled")
	state_add("idle")
	state_add("borking")
	call_deferred("state_set", states.kenneled)
#------------------------------------------------------------------------------#
#State Label
func _process(_delta: float) -> void: state_label.text = str(states.keys()[state])
#------------------------------------------------------------------------------#
#State Machine
#State Logistics
func state_logic(_delta):
	match(state):
		states.kenneled: pass
#State Transitions
@warning_ignore("unused_parameter")
func transitions(delta):
	match(state):
		states.kenneled: if pubby.rescued: return states.idle
		states.idle: if pubby.bork_ray.is_colliding(): return states.borking
		states.borking: if !pubby.bork_ray.is_colliding(): return states.idle
	return null
#Enter State
@warning_ignore("unused_parameter")
func state_enter(new_state, old_state):
	match(new_state):
		states.kenneled: pubby.set_deferred("visible", false)
		states.idle: pubby.pubby_player.play("idle")
		states.borking: pubby.pubby_player.play("angy")
#Exit State
@warning_ignore("unused_parameter")
func state_exit(old_state, new_state):
	match(old_state):
		states.kenneled: pubby.set_deferred("visible", true)
