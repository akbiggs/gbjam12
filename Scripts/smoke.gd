extends AnimatedSprite2D

var _x_speed : float
var _y_speed : float
var _life : float
var _rng = RandomNumberGenerator.new()


func _ready() -> void:
	_x_speed = _rng.randf_range(0.5, 2)
	_y_speed = _rng.randf_range(-6, -2)
	_life = _rng.randf_range(2, 4)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x += _x_speed * delta
	global_position.y += _y_speed * delta
	_life -= delta
	if _life <= 0:
		queue_free()
