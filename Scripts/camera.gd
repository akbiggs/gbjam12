class_name MyCamera
extends Node2D

const MOVE_SPEED = 2

signal wake_room # Starts processing the room.
signal sleep_room # Stops processing the room. 
signal reset_room # Resets the state of the room back to normal. Only call when
				  # room is off-screen.
# signal revive_room?

var _target_transform: Transform2D
var _has_target = false
var _x_index = 0
var _y_index = 0
var _previous_x_index = 0
var _previous_y_index = 0

@export var player : Node2D

func _ready() -> void:
	snap_to(0, -2)

func _process(delta: float) -> void:
	# Change target if the player wants to go to a new room.
	#
	# There is a bit of padding to prevent swapping back and forth between rooms.
	if !_has_target:
		# Left
		if player.position.x + 6 < -_x_index * 160:
			move_to(_x_index + 1, _y_index)
		# Right
		if player.position.x + 6 > -_x_index * 160 + 160:
			move_to(_x_index - 1, _y_index)
		# Up
		if player.position.y + 6 < -_y_index * 128 + 16:
			move_to(_x_index, _y_index + 1)
		# Down
		if player.position.y + 6 > -_y_index * 128 + 144:
			move_to(_x_index, _y_index - 1)
	
	# Move the camera towards the target.
	var target_position = _target_transform.get_origin() if _has_target else Vector2.ZERO
	if _has_target && position.distance_squared_to(target_position) > 0:
		position = position.move_toward(target_position, MOVE_SPEED)
		get_viewport().canvas_transform = Transform2D.IDENTITY.translated(position)
	elif _has_target: # Transition finished.
		_has_target = false
		
		# Wake the current room and reset the state of the previous room now that
		# the transition is finished.
		reset_room.emit(_previous_x_index, _previous_y_index)
		wake_room.emit(_x_index, _y_index)

func _get_target(x_index: int, y_index: int) -> Transform2D:
	return Transform2D.IDENTITY.translated(Vector2(x_index * 160, y_index * 128))

func move_to(x_index: int, y_index: int):
	if !_has_target:
		_target_transform = _get_target(x_index, y_index)
		_has_target = true
		
		# Sleep the previous room while we transition. We don't wake the new room
		# until the transition ends so the player can't get attacked
		# mid-transition.
		sleep_room.emit(_x_index, _y_index)
		_previous_x_index = _x_index
		_previous_y_index = _y_index
		_x_index = x_index
		_y_index = y_index

func snap_to(x_index: int, y_index: int):
	_target_transform = _get_target(x_index, y_index)
	position = _target_transform.get_origin()
	get_viewport().canvas_transform = _target_transform
	_has_target = false
	# Sleep previous room and wake current room.
	sleep_room.emit(_x_index, _y_index)
	wake_room.emit(x_index, y_index)
	_x_index = x_index
	_y_index = y_index

func has_target() -> bool:
	return _has_target
