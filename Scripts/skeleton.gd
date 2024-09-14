extends CharacterBody2D

enum SkeletonState {
	IDLE,
	WALK,
	THROW_WINDUP,
	THROW
}

const SPEED = 20.0

@onready var player = %Player
@onready var sprite : AnimatedSprite2D = $Sprite
var _rng = RandomNumberGenerator.new()
var _state : SkeletonState = SkeletonState.IDLE
var _idle_timer : float
var _throw_windup_timer : float
var _throw_timer : float
var _walk_timer : float

func _reset_timers() -> void:
	_idle_timer = _rng.randf_range(0.4, 1.5)
	_walk_timer = _rng.randf_range(1.5, 3)
	_throw_windup_timer = _rng.randf_range(0.8, 1.1)
	_throw_timer = _rng.randf_range(1.2, 2.8)

func _ready() -> void:
	_reset_timers()

func _physics_process(delta: float) -> void:
	if _state == SkeletonState.IDLE:
		_idle_timer -= delta
		if _idle_timer <= 0:
			_state = SkeletonState.WALK
			sprite.play("walk")
			_reset_timers()
	elif _state == SkeletonState.WALK:
		_walk_timer -= delta
		
		var direction = (player.position - position).normalized()
		velocity = direction * SPEED
		move_and_slide()

		if _walk_timer <= 0:
			_state = SkeletonState.THROW_WINDUP
			sprite.play("angry")
			_reset_timers()
	elif _state == SkeletonState.THROW_WINDUP:
		_throw_windup_timer -= delta
		if _throw_windup_timer <= 0:
			_state = SkeletonState.THROW
			sprite.play("throw")
			# TODO: Spawn bullet.
			_reset_timers()
	elif _state == SkeletonState.THROW:
		_throw_timer -= delta
		if _throw_timer <= 0:
			_state = SkeletonState.WALK
			sprite.play("walk")
			_reset_timers()
