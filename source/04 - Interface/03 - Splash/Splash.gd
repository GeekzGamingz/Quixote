extends Control
#------------------------------------------------------------------------------#
#Constants
const RESUME_CLICKED = preload("uid://3do4o7jfdu34")
const RESUME_HOVERED = preload("uid://p5kfjo6per0w")
const RESUME_UNCLICKED = preload("uid://c8vluhp5by37b")
#------------------------------------------------------------------------------#
#Variables
#OnReady Variables
@onready var start_button: TextureButton = $HButtonContainer/VButtonContainer/StartButton
@onready var restart_button: TextureButton = $HButtonContainer/VButtonContainer/RestartButton
@onready var fx_slider: HSlider = $HButtonContainer2/VButtonContainer/VolumeContainer/EffectsContainer/EffectsSlider
@onready var ambi_slider: HSlider = $HButtonContainer2/VButtonContainer/VolumeContainer/AmbienceContainer/AmbienceSlider
@onready var music_slider: HSlider = $HButtonContainer2/VButtonContainer/VolumeContainer/MusicContainer/MusicSlider
#------------------------------------------------------------------------------#
#Functions
var begun: bool = false
#Ready
func _ready() -> void: paused(true)
#Input
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("action_menu"):
		visible = !visible
		paused(visible)
#------------------------------------------------------------------------------#
#Custom Functions
func paused(is_paused): get_tree().paused = is_paused
#------------------------------------------------------------------------------#
#Signaled Functions
#Start Button
func _on_start_button_up() -> void:
	set_deferred("visible", false)
	paused(false)
	if !begun:
		begun = true
		start_button.texture_normal = RESUME_UNCLICKED
		start_button.texture_hover = RESUME_HOVERED
		start_button.texture_pressed = RESUME_CLICKED
		start_button.offset_transform_enabled = false
		restart_button.set_deferred("visible", true)
#Restart Button
func _on_restart_button_up() -> void: get_tree().reload_current_scene()
#Quit Button
func _on_quit_button_up() -> void: get_tree().quit()
#Slider Signals
func _on_effects_slider_value_changed(value: float) -> void: check_volume("Effects", value)
func _on_ambience_slider_value_changed(value: float) -> void: check_volume("Ambience", value)
func _on_music_slider_value_changed(value: float) -> void: check_volume("Music", value)
#------------------------------------------------------------------------------#
#Custom Functions
func check_volume(type, value):
	var bus = AudioServer.get_bus_index(type)
	AudioServer.set_bus_volume_db(bus, value)
