#Inherits StateMachine Code
extends StateMachine
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var quixote: CharacterBody2D = $".."
@onready var state_label: Label = $"../Outputs/StateOutput"
#------------------------------------------------------------------------------#
#Ready Method
func _ready() -> void:
	#Add States
	state_add("idle")
	state_add("ride_forth")
	state_add("to_arms")
	state_add("bracing")
	call_deferred("state_set", states.ride_forth)
#------------------------------------------------------------------------------#
#State Label
func _process(_delta: float) -> void: state_label.text = str(states.keys()[state])
#------------------------------------------------------------------------------#
#State Machine
#State Logistics
func state_logic(delta):
	match(state):
		states.idle: pass
		states.ride_forth, states.bracing: quixote.ride_forth(delta)
#State Transitions
@warning_ignore("unused_parameter")
func transitions(delta):
	match(state):
		#Default
		states.idle:
			if quixote.horse_speed > 0: return states.ride_forth
			if quixote.horse_speed < 0: return states.bracing
		states.ride_forth: 
			if quixote.horse_speed < 1: return states.idle
			if quixote.lance.is_colliding(): return states.to_arms
		states.bracing: if quixote.horse_speed > -1: return states.idle
		states.to_arms: if quixote.horse_speed < 0: return states.idle
	return null
#Enter State
@warning_ignore("unused_parameter")
func state_enter(new_state, old_state):
	match(new_state):
		states.idle: quixote.anim_player.play("idle")
		states.ride_forth: quixote.anim_player.play("ride_forth")
		states.to_arms: quixote.anim_player.play("to_arms")
		states.bracing: quixote.anim_player.play("bracing")
#Exit State
@warning_ignore("unused_parameter")
func state_exit(old_state, new_state):
	match(old_state):
		states.idle: pass
