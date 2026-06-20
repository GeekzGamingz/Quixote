extends CharacterBody2D
#------------------------------------------------------------------------------#
signal quixote_damage
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
@export_range(1, 10, 1, "prefer_slider") var horse_speed: int
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#Local Nodes
@onready var lance: RayCast2D = $Facing/RayCast2D
@onready var starting_speed: int = horse_speed
@onready var geriatric_timer: Timer = $Timers/GeriatricTimer
@onready var anim_player: AnimationPlayer = $AnimationPlayers/SpritePlayer
#------------------------------------------------------------------------------#
#Ready
func _ready() -> void:
	await get_tree().process_frame
	MAIN.WINDMILL.connect("spin", impede)
#------------------------------------------------------------------------------#
#Signaled Functions
func _on_geriatric_timeout() -> void: emit_signal("quixote_damage", "Geriatric", 20)
#------------------------------------------------------------------------------#
#Custom Functions
func ride_forth(delta): global_position.x += horse_speed * delta
#------------------------------------------------------------------------------#
#Custom Signaled Functions
func impede(spinning, wind_speed):
	if spinning: horse_speed -= wind_speed
	else: horse_speed = starting_speed
	print("Wind Speed: ", wind_speed)
	print("Horse Speed: ", horse_speed)
