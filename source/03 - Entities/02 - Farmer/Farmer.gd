extends CharacterBody2D
#------------------------------------------------------------------------------#
const FORK = preload("uid://bn3i5tdhe6w3c")
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
@export var quixote: CharacterBody2D
@export var participating: bool = false
#OnReady Variables
#Main
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#Local
@onready var fork_zone: Marker2D = $ForkZone
@onready var sprite_barrel: Sprite2D = $Sprites/SpriteBarrel
@onready var sprite_player: AnimationPlayer = $AnimationPlayers/SpritePlayer
#------------------------------------------------------------------------------#
#Functions
#Ready
func _ready() -> void:
	await get_tree().process_frame
	MAIN.SHOP.farmer_button.connect("anger", anger)
#------------------------------------------------------------------------------#
#Signaled Functions
func _on_sprite_animation_finished(anim_name: StringName) -> void:
	match(anim_name):
		"angy": sprite_player.play("huck")
#------------------------------------------------------------------------------#
#Custom Functions
func huck_fork():
	var fork_scene = FORK.instantiate()
	MAIN.ORPHANAGE.add_child(fork_scene)
	fork_scene.global_position = fork_zone.global_position
#------------------------------------------------------------------------------#
#Custom Signaled Function
func anger():
	participating = true
	sprite_barrel.set_deferred("visible", true)
