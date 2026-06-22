extends StaticBody2D
#------------------------------------------------------------------------------#
signal fence_repair
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
@export_enum(
	"Unbuilt",
	"Built",
	"Broken"
) var state: String = "Unbuilt"
#OnReady Variables
#Main Nodes
@onready var MAIN: Node2D = get_tree().get_root().get_node("Main")
#Local Nodes
@onready var sprite_base: Sprite2D = $Sprites/SpriteBase
@onready var sprites_broken: Node2D = $Sprites/SpritesBroken
@onready var collision: CollisionShape2D = $CollisionShape2D
#------------------------------------------------------------------------------#
#Functions
#Ready
func _ready() -> void:
	check_fence()
	await get_tree().process_frame
	MAIN.SHOP.fence_button.connect("erect_fence", erect)
#------------------------------------------------------------------------------#
#Custom Functions
func check_fence():
	sprite_base.set_deferred("visible", false)
	sprites_broken.set_deferred("visible", false)
	collision.set_deferred("disabled", false)
	match(state):
		"Unbuilt": collision.set_deferred("disabled", true)
		"Built": sprite_base.set_deferred("visible", true)
		"Broken":
			collision.set_deferred("disabled", true)
			sprites_broken.set_deferred("visible", true)
#------------------------------------------------------------------------------#
#Custom Signaled Functions
func erect():
	state = "Built"
	emit_signal("fence_repair", 100)
	check_fence()
