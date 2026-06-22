extends CharacterBody2D
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
@export_range(1, 10, 1, "prefer_slider") var donkey_speed: int
#OnReady Variables
@onready var position_ray: RayCast2D = $RayCasts/PositionRay
@onready var sprite_player: AnimationPlayer = $AnimationPlayers/AnimationPlayer
@onready var idle_timer: Timer = $Timers/IdleTimer
#------------------------------------------------------------------------------#
#Custom Functions
func ride_forth(delta): global_position.x += donkey_speed * delta
