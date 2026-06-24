extends AudioStreamPlayer2D
#------------------------------------------------------------------------------#
#Custom Functions
#Fade Out
func fade_out(): if playing:
	var tween = create_tween()
	tween.tween_property(self, "volume_db", -50, 1)
	tween.play()
	tween.tween_callback(reset)
#Reset Audio
func reset():
	stop()
	volume_db = 0.0
