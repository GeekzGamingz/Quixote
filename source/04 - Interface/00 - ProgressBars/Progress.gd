extends CenterContainer
#------------------------------------------------------------------------------#
#Exported Variables
@export var progress_under: TextureProgressBar
@export var progress_over = TextureProgressBar
#------------------------------------------------------------------------------#
#Progress Updater
#Heal Progress
func progress_heal(value):
		var heal = progress_under.value + value
		var tween = create_tween()
		tween.set_parallel()
		tween.tween_property(progress_over, "value", heal, 1)
		tween.tween_property(progress_under, "value", heal, 0.5)
		tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.play()
#Damage Progress
func progress_damage(value):
		var damage = progress_over.value - value
		var tween = create_tween()
		tween.set_parallel()
		tween.tween_property(progress_over, "value", damage, 0.5)
		tween.tween_property(progress_under, "value", damage, 1)
		tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.play()
#Max Progress Updater
func max_progress_updater(max_progress):
	progress_over.max_value = max_progress
	progress_under.max_value = max_progress
