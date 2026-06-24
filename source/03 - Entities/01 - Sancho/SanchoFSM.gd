#Inherits StateMachine Code
extends StateMachine
#------------------------------------------------------------------------------#
#Signals
signal target_acquired
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var sancho: CharacterBody2D = $".."
@onready var state_label: Label = $"../Outputs/StateOutput"
#------------------------------------------------------------------------------#
#Ready Method
func _ready() -> void:
	#Add States
	state_add("intro")
	state_add("idle")
	state_add("strumming")
	state_add("rocking")
	call_deferred("state_set", states.intro)
#------------------------------------------------------------------------------#
#State Label
func _process(_delta: float) -> void: state_label.text = str(states.keys()[state])
#------------------------------------------------------------------------------#
#State Machine
#State Logistics
func state_logic(delta):
	match(state):
		states.intro: sancho.ride_forth(delta)
#State Transitions
@warning_ignore("unused_parameter")
func transitions(delta):
	match(state):
		#Idle
		states.intro: if sancho.position_ray.is_colliding(): return states.idle
		states.idle: if sancho.idle_timer.is_stopped(): return states.strumming
		states.strumming: if sancho.participating: return states.rocking
	return null
#Enter State
@warning_ignore("unused_parameter")
func state_enter(new_state, old_state):
	match(new_state):
		states.intro: sancho.sprite_player.play("ride_forth")
		states.idle: 
			sancho.idle_timer.start()
			sancho.sprite_player.play("idle")
		states.strumming:
			sancho.sprite_player.play("strum")
			emit_signal("target_acquired")
		states.rocking: sancho.rock_on(true)
#Exit State
@warning_ignore("unused_parameter")
func state_exit(old_state, new_state):
	match(old_state):
		states.intro: pass
		states.rocking: sancho.rock_on(false)
