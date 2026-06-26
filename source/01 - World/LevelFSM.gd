#Inherits StateMachine Code
extends StateMachine
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var level: Node2D = $".."
#------------------------------------------------------------------------------#
#Ready Method
func _ready() -> void:
	#Add States
	state_add("Prologue")
	state_add("I")
	state_add("II")
	state_add("III")
	state_add("IV")
	state_add("V")
	state_add("VI")
	state_add("VII")
	state_add("Intermission")
	state_add("Epilogue")
	state_add("Defeated")
	call_deferred("state_set", states.Prologue)
#------------------------------------------------------------------------------#
#State Label
func _process(_delta: float) -> void: level.notifier.title_label.text = str("[Day: ", states.keys()[state], "]")
#------------------------------------------------------------------------------#
#State Machine
#State Logistics
func state_logic(_delta):
	match(state):
		states.Prologue: pass
#State Transitions
@warning_ignore("unused_parameter")
func transitions(delta):
	match(state):
		#Idle
		states.Prologue: if level.level == 1: return states.I
		states.I, states.II, states.III, states.IV, states.V, states.VI:
			if level.quixote.collapsed: return states.Intermission
			if level.windmill.collapsed: return states.Defeated
		states.VII:
			if level.quixote.collapsed: return states.Epilogue
			if level.windmill.collapsed: return states.Defeated
		states.Intermission: if level.intermission_over:
			match(level.level):
				1: return states.II
				2: return states.III
				3: return states.IV
				4: return states.V
				5: return states.VI
				6: return states.VII
	return null
#Enter State
@warning_ignore("unused_parameter")
func state_enter(new_state, old_state):
	match(new_state):
		states.Intermission: level.change_scene()
		states.Defeated: level.game_over("Lost")
#Exit State
@warning_ignore("unused_parameter")
func state_exit(old_state, new_state):
	match(old_state):
		states.Prologue: pass
		states.Intermission:
			level.intermission_over = false
			level.quixote.upgrades.check_upgrade(level.level)
