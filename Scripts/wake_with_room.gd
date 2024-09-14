extends Node2D

@onready var camera : MyCamera = %Camera
var parent : Node2D
var start_position : Vector2
var room_x = 0
var room_y = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()
	start_position = parent.global_position
	room_x = ceil(-(global_position.x / 160))
	print(room_x)
	room_y = ceil(-(global_position.y / 128))
	print(room_y)
	camera.wake_room.connect(_wake_if_woken_room)
	camera.sleep_room.connect(_sleep_if_slept_room)
	camera.reset_room.connect(_reset_if_reset_room)
	
	# Start asleep.
	parent.process_mode = Node.PROCESS_MODE_DISABLED

func _wake_if_woken_room(x_index: int, y_index: int) -> void:
	if room_x != x_index || room_y != y_index:
		return

	parent.process_mode = Node.PROCESS_MODE_PAUSABLE
	
func _sleep_if_slept_room(x_index: int, y_index: int) -> void:
	if room_x != x_index || room_y != y_index:
		return

	parent.process_mode = Node.PROCESS_MODE_DISABLED

func _reset_if_reset_room(x_index: int, y_index: int) -> void:
	if room_x != x_index || room_y != y_index:
		return

	parent.global_position = start_position
	parent.process_mode = Node.PROCESS_MODE_DISABLED
