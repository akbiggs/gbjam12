extends Node2D

const SMOKE_TIME_MAX = 1;
const SMOKE_TIME_MIN = 0.5;

var _time_until_next_smoke = 0;
var _rng = RandomNumberGenerator.new()

var smoke_scene = preload("res://Scenes/smoke.tscn") as PackedScene

func _physics_process(delta: float) -> void:
	_time_until_next_smoke -= delta
	if _time_until_next_smoke <= 0:
		_time_until_next_smoke = _rng.randf_range(SMOKE_TIME_MIN, SMOKE_TIME_MAX)
		var smoke = smoke_scene.instantiate() as Node2D
		add_child(smoke)
		smoke.translate(Vector2(4, -2))
		
