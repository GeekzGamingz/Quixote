extends Node
#------------------------------------------------------------------------------#
#Constants
#Cursors
const CURSOR_FRAMES: Array = [
	preload("uid://fley442ohmc6"),
	preload("uid://doe44gavlc8uf"),
	preload("uid://doginspsk0a0f"),
	preload("uid://bbwnocjqnb4rg")
]
#------------------------------------------------------------------------------#
#Variables
#Integers
var current_frame: int = 0
#Vectors
var cursor_size_base: Vector2 = Vector2(16, 16)
#OnReady Variables
@onready var current_cursor = CURSOR_FRAMES[0]
@onready var timer: Timer = Timer.new()
@onready var window_size_base: Vector2 = get_window().size
#------------------------------------------------------------------------------#
#Ready Function
func _ready() -> void:
	$"/root".set_script(load("uid://07hhaodskvs2"))
	resize_cursor(current_cursor)
	set_timer(2.0)
#------------------------------------------------------------------------------#
#Custom Signaled Functions
#Update Frames
func update_frames():
	current_frame += 1
	resize_cursor(CURSOR_FRAMES[current_frame])
	await get_tree().create_timer(0.1).timeout
	current_frame += 1
	resize_cursor(CURSOR_FRAMES[current_frame])
	await get_tree().create_timer(0.1).timeout
	current_frame += 1
	resize_cursor(CURSOR_FRAMES[current_frame])
	await get_tree().create_timer(0.1).timeout
	current_frame = 0
	resize_cursor(CURSOR_FRAMES[current_frame])
#------------------------------------------------------------------------------#
#Custom Functions
#Set Timer
func set_timer(time):
	add_child(timer)
	timer.autostart = true
	timer.wait_time = time
	timer.timeout.connect(update_frames)
	timer.start()
#Resize Cursor
func resize_cursor(cursor):
	var window_size = get_window().size * 2
	var scale = min(
		snapped(window_size.x / window_size_base.x, 0.01),
		snapped(window_size.y / window_size_base.y, 0.01)
	)
	var image = cursor.get_image()
	image.resize(
		cursor_size_base.x * scale, cursor_size_base.y * scale, Image.INTERPOLATE_NEAREST
	)
	ImageTexture.create_from_image(image)
	Input.set_custom_mouse_cursor(image)
