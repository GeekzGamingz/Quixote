extends Control
#------------------------------------------------------------------------------#
#Constants
const MENU_OPEN = preload("uid://dt5cj6o2b2vg4")
const MENU_CLOSE = preload("uid://dgcmle72qexw3")
#------------------------------------------------------------------------------#
#Variables
#Bools
var shown: bool = false
#OnReady Variables
#Buttons
@onready var repair_button: TextureButton = $VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/GridContainer/RepairButton
@onready var upgrade_button: TextureButton = $VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/GridContainer/UpgradeButton
@onready var rotation_button: TextureButton = $VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/GridContainer/RotationButton
@onready var fence_button: TextureButton = $VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/GridContainer/FenceButton
@onready var unknown_button: TextureButton = $VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/GridContainer/UnknownButton
@onready var farmer_button: TextureButton = $VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/GridContainer/FarmerButton
@onready var growth_button: TextureButton = $VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/GridContainer/GrowthButton
@onready var pubby_button: TextureButton = $VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/GridContainer/PubbyButton
@onready var yield_button: TextureButton = $VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/GridContainer/YieldButton
#Effect Players
@onready var shop_player: AnimationPlayer = $AnimationPlayers/ShopPlayer
@onready var audio_menu: AudioStreamPlayer2D = $AudioPlayers/MenuPlayer
@onready var audio_buttons: AudioStreamPlayer2D = $AudioPlayers/ButtonPlayer
#------------------------------------------------------------------------------#
#Signaled Functions
#Mouse Entered
func _on_shop_mouse_entered() -> void:
	if !shown:
		audio_menu.stream = MENU_OPEN
		audio_menu.play()
		shop_player.play("show")
		shown = true
#Mouse Exited
func _on_shop_area_exited() -> void:
	if shown:
		audio_menu.stream = MENU_CLOSE
		audio_menu.play()
		shop_player.play("hide")
		shown = false
