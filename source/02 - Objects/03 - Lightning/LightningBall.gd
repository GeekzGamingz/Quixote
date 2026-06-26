extends RigidBody2D
#------------------------------------------------------------------------------#
#Variables
var quixote: CharacterBody2D
var direction = Vector2.ZERO
#Exported Variables
@export_range(100, 200, 25) var speed = 100
#OnReady Variables
@onready var anim_player: AnimationPlayer = $AnimationPlayer
#------------------------------------------------------------------------------#
#Functions
#Process
func _process(delta: float) -> void:
	if quixote != null:
		global_position += direction * speed * delta
		look_at(quixote.global_position)
#------------------------------------------------------------------------------#
#Signaled Functions
#Screen Exited
func _on_screen_exited() -> void: queue_free()
#Body Entered
func _on_hitbox_body_entered(body: Node2D) -> void:
	match(body.name):
		"Quixote": body.emit_signal("quixote_damage", "Electric", 10)
	anim_player.play("impact")
	await anim_player.animation_finished
	queue_free()
#------------------------------------------------------------------------------#
#Custom Functions
#Launch
func launch(target):
	quixote = target
	direction = (quixote.global_position - global_position).normalized()
	look_at(direction)
