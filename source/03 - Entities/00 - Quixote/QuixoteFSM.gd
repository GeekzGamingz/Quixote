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
	state_add("intro")
	state_add("idle")
	state_add("ride_forth")
	state_add("to_arms")
	state_add("bracing")
	state_add("brace_max")
	state_add("collapsed")
	state_add("victorious")
	call_deferred("state_set", states.intro)
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
		states.intro: if quixote.windmill_sighted: return states.ride_forth
		states.idle:
			if quixote.horse_speed > 0: return states.ride_forth
			if quixote.horse_speed < 0: return states.bracing
			if quixote.collapsed: return states.collapsed
		states.ride_forth: 
			if quixote.horse_speed < 1: return states.idle
			if quixote.lance.is_colliding(): return states.to_arms
			if quixote.collapsed: return states.collapsed
		states.bracing:
			if quixote.horse_speed > -1: return states.idle
			if quixote.brace_cast.is_colliding(): return states.brace_max
			if quixote.collapsed: return states.collapsed
		states.brace_max:
			if quixote.horse_speed > -1: return states.idle
			if quixote.collapsed: return states.collapsed
		states.to_arms:
			if quixote.horse_speed < 0: return states.idle
			if quixote.collapsed: return states.collapsed
			if quixote.victorious: return states.victorious
			if quixote.path_clear: return states.idle
	return null
#Enter State
@warning_ignore("unused_parameter")
func state_enter(new_state, old_state):
	match(new_state):
		states.idle:
			quixote.path_clear = false
			quixote.sprite_player.play("idle")
		states.ride_forth: quixote.sprite_player.play("ride_forth")
		states.to_arms: quixote.sprite_player.play("to_arms")
		states.bracing: quixote.sprite_player.play("bracing")
		states.brace_max: quixote.sprite_player.play("brace_max")
		states.collapsed: quixote.sprite_player.play("collapsing")
		states.victorious: quixote.sprite_player.play("victory")
#Exit State
@warning_ignore("unused_parameter")
func state_exit(old_state, new_state):
	match(old_state):
		states.idle: pass
