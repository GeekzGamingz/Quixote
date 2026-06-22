extends Control
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
#Animation Player
@onready var shop_player: AnimationPlayer = $AnimationPlayers/ShopPlayer
#------------------------------------------------------------------------------#
#Signaled Functions
#Mouse Entered
func _on_shop_mouse_entered() -> void:
	if !shown:
		shop_player.play("show")
		shown = true
#Mouse Exited
func _on_shop_area_exited() -> void:
	if shown:
		shop_player.play("hide")
		shown = false
