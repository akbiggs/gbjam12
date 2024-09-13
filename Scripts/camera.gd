class_name MyCamera
extends Node2D

var _target_transform: Transform2D
var _has_target = false
var _x_index = 0
var _y_index = 0
const MOVE_SPEED = 2

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
	else:
		_has_target = false

func _get_target(x_index: int, y_index: int) -> Transform2D:
	return Transform2D.IDENTITY.translated(Vector2(x_index * 160, y_index * 128))

func move_to(x_index: int, y_index: int):
	if !_has_target:
		_target_transform = _get_target(x_index, y_index)
		_has_target = true
		_x_index = x_index
		_y_index = y_index
		print(x_index)

func snap_to(x_index: int, y_index: int):
	_target_transform = _get_target(x_index, y_index)
	position = _target_transform.get_origin()
	get_viewport().canvas_transform = _target_transform
	_has_target = false
	_x_index = x_index
	_y_index = y_index

func has_target() -> bool:
	return _has_target
