extends Control
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var bg_rect: TextureRect = $BackgroundRect
@onready var sprite_arms: Sprite2D = $SpriteArms
@onready var anim_player: AnimationPlayer = $AnimationPlayer
#------------------------------------------------------------------------------#
#Signaled Functions
#Restart Button
func _on_restart_button_up() -> void:
	anim_player.play("fade_out")
	await anim_player.animation_finished
	get_tree().reload_current_scene()
	get_parent().remove_child(self)
#Quit Button
func _on_quit_button_up() -> void:
	anim_player.play("fade_out")
	await anim_player.animation_finished
	get_tree().quit()
