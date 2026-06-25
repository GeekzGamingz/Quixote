extends RigidBody2D
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
@export_range(10, 50, 1) var speed: float = 25
#OnReady Variables
@onready var anim_player: AnimationPlayer = $AnimationPlayer
#------------------------------------------------------------------------------#
#Functions
#Process
func _process(delta: float) -> void: global_position.x += speed * delta
#------------------------------------------------------------------------------#
#Signaled Functions
#Screen Exited
func _on_screen_exited() -> void: queue_free()
#Body Entered
func _on_hitbox_body_entered(body: Node2D) -> void:
	match(body.name):
		"Windmill":
			body.take_damage("Minstrel")
			anim_player.play("impact")
		"BorkShield": anim_player.play("impact")
#Animation Player Finished
func _on_animation_player_finished(anim_name: StringName) -> void:
	match(anim_name):
		"impact": queue_free()
		"charge": anim_player.play("shoot")
