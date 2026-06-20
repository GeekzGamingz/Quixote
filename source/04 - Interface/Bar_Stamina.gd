extends CenterContainer
#------------------------------------------------------------------------------#
#OnReady Variables
@onready var stamina_under = $StaminaUnder
@onready var stamina_over = $StaminaOver
#------------------------------------------------------------------------------#
#Stamina Updater
#Heal Stamina
func stamina_heal(value):
	var heal = stamina_under.value + value
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(stamina_over, "value", heal, 2)
	tween.tween_property(stamina_under, "value", heal, 1)
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.play()
#Damage Stamina
func stamina_damage(value):
	var damage = stamina_over.value - value
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(stamina_over, "value", damage, 0.5)
	tween.tween_property(stamina_under, "value", damage, 5)
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.play()
#Max Stamina Updater
func max_stamina_updater(max_stamina):
	stamina_over.max_value = max_stamina
	stamina_under.max_value = max_stamina
