extends CharacterBody2D
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
#Bools
@export var rescued = false
#OnReady Variables
#Main
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#Local
@onready var bork_ray: RayCast2D = $RayCasts/BorkRay
@onready var pubby_player: AnimationPlayer = $AnimationPlayers/PubbyPlayer
@onready var bork_audio: AudioStreamPlayer2D = $AudioPlayers/BorkAudio
#------------------------------------------------------------------------------#
#Functions
#Ready
func _ready() -> void:
	await get_tree().process_frame
	MAIN.SHOP.pubby_button.connect("rescue", rescue)
#------------------------------------------------------------------------------#
#Custom Functions
func bork(): bork_audio.play()
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Rescue
func rescue(): rescued = true
