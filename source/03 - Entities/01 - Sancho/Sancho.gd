extends CharacterBody2D
#------------------------------------------------------------------------------#
#Constants
const MUSIC = preload("uid://dgr6esfwxl7ux")
#------------------------------------------------------------------------------#
#Variables
@export var participating: bool = false
@export_range(1, 10, 1, "prefer_slider") var donkey_speed: int = 3
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#Local Nodes
@onready var position_ray: RayCast2D = $RayCasts/PositionRay
@onready var sprite_player: AnimationPlayer = $AnimationPlayers/AnimationPlayer
@onready var idle_timer: Timer = $Timers/IdleTimer
@onready var music_timer: Timer = $Timers/MusicTimer
@onready var rock_zone: Marker2D = $RockZone
#------------------------------------------------------------------------------#
#Signaled Functions
func _on_music_timer_timeout() -> void:
	var music_scene = MUSIC.instantiate()
	MAIN.ORPHANAGE.add_child(music_scene)
	music_scene.global_position = rock_zone.global_position
#------------------------------------------------------------------------------#
#Custom Functions
func ride_forth(delta): global_position.x += donkey_speed * delta
func rock_on(is_rocking): match(is_rocking):
	true: music_timer.start()
	false: music_timer.stop()
