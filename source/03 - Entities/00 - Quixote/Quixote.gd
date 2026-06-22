extends CharacterBody2D
#------------------------------------------------------------------------------#
signal quixote_damage
signal windmill_damage
signal fence_damage
#------------------------------------------------------------------------------#
#Variables
#Bools
var on_screen: bool = false
var collapsed: bool = false
var victorious: bool = false
var windmill_sighted: bool = false
#Integers
var geriatric_damage: int = 10
#Exported Variables
@export_category("Geriatric Damage")
@export_range(10, 30, 5, "prefer_slider") var geriatric_damage_base = geriatric_damage
@export_range(10, 30, 5, "prefer_slider") var geriatric_damage_max = geriatric_damage
@export_range(5, 20, 1, "prefer_slider") var geriatric_ticks = 10
@export_category("Traits")
@export_range(5, 20, 1, "prefer_slider") var lance_damage: int = 5
@export_range(1, 10, 1, "prefer_slider") var horse_speed: int = 5
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#Local Nodes
@onready var lance: RayCast2D = $RayCasts/LanceRay
@onready var brace_cast: RayCast2D = $RayCasts/BraceRay
@onready var starting_speed: int = horse_speed
@onready var geriatric_timer: Timer = $Timers/GeriatricTimer
@onready var sprite_player: AnimationPlayer = $AnimationPlayers/SpritePlayer
#------------------------------------------------------------------------------#
#Ready
func _ready() -> void:
	await get_tree().process_frame
	MAIN.WINDMILL.connect("spin", impede)
	MAIN.PROGRESS.connect("collapse", collapse)
	MAIN.SANCHO.get_node("SanchoFSM").connect("target_acquired", target_acquired)
#------------------------------------------------------------------------------#
#Signaled Functions
#Animation Players
func _on_sprite_player_finished(_anim_name: StringName) -> void: sprite_player.play("collapsed")
#Timers
func _on_geriatric_timeout() -> void:
	if on_screen && !collapsed && !victorious: emit_signal("quixote_damage", "Geriatric", geriatric_damage)
#Screen Notifier
func _on_screen_notifier_entered() -> void: on_screen = true
#------------------------------------------------------------------------------#
#Custom Functions
func ride_forth(delta): global_position.x += horse_speed * delta
func attack_lance():
	match(lance.get_collider().name):
		"Windmill": emit_signal("windmill_damage", "Lance", lance_damage)
		"Fence": emit_signal("fence_damage", "Lance", lance_damage)
func collapse(origin):
	if !collapsed:
		match(origin.name):
			"Quixote": collapsed = true
			"Windmill": victorious = true
		print("#---[", self.name, "] Witnessed [", origin.name, "]'s Collapse!---#")
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Impede
func impede(spinning, wind_speed):
	if on_screen:
		if spinning:
			horse_speed -= wind_speed
			geriatric_timer.wait_time = 5.0
			geriatric_timer.start()
			geriatric_damage = geriatric_damage_max
		else:
			horse_speed = starting_speed
			geriatric_timer.wait_time = 10.0
			geriatric_timer.start()
			geriatric_damage = geriatric_damage_base
		print("Wind Speed: ", wind_speed)
		print("Horse Speed: ", horse_speed)
#Target Acquired
func target_acquired():
	print("WINDMILL SIGHTED!")
	windmill_sighted = true
