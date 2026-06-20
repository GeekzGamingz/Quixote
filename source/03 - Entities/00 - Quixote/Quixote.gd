extends CharacterBody2D
#------------------------------------------------------------------------------#
signal quixote_damage
#------------------------------------------------------------------------------#
#Variables
var geriatric_damage: int = 10
#Exported Variables
@export_category("Geriatric Damage")
@export_range(10, 30, 5, "prefer_slider") var geriatric_damage_base = geriatric_damage
@export_range(10, 30, 5, "prefer_slider") var geriatric_damage_max = geriatric_damage
@export_range(5, 10, 1, "prefer_slider") var geriatric_ticks: = 10
@export_category("Traits")
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
func _on_geriatric_timeout() -> void: emit_signal("quixote_damage", "Geriatric", geriatric_damage)
#------------------------------------------------------------------------------#
#Custom Functions
func ride_forth(delta): global_position.x += horse_speed * delta
#------------------------------------------------------------------------------#
#Custom Signaled Functions
func impede(spinning, wind_speed):
	if spinning:
		horse_speed -= wind_speed
		geriatric_timer.wait_time = 5.0
		geriatric_damage = geriatric_damage_max
	else:
		horse_speed = starting_speed
		geriatric_timer.wait_time = 10.0
		geriatric_damage = geriatric_damage_base
	print("Wind Speed: ", wind_speed)
	print("Horse Speed: ", horse_speed)
