extends PanelContainer
#------------------------------------------------------------------------------#
#Variables
#Strings
@export var default: String = "It seems this message was [wave]lost[/wave] to time..."
#On Ready Variables
@onready var label: RichTextLabel = $MessageLabel
@onready var anim_player: AnimationPlayer = $AnimationPlayer
#------------------------------------------------------------------------------#
#Functions
#Ready
func _ready() -> void: load_message(default, null)
#------------------------------------------------------------------------------#
#Custom Functions
#Load Message
func load_message(message, timeout):
	label.bbcode_text = message
	if timeout != null:
		await get_tree().create_timer(timeout).timeout
		anim_player.play("hide")
		await anim_player.animation_finished
		queue_free()
