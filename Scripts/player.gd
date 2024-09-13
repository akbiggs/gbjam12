extends CharacterBody2D

@export var sprite : AnimatedSprite2D
@export var camera : MyCamera

const SPEED = 100.0

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	# Don't allow the player to move while the camera is moving rooms.
	if camera.has_target():
		return

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var x_direction := Input.get_axis("ui_left", "ui_right")
	var y_direction := Input.get_axis("ui_up", "ui_down")
	
	if abs(x_direction) > 0 or abs(y_direction) > 0:
		var direction = Vector2(x_direction, y_direction).normalized()
		velocity = direction * SPEED
		sprite.play("walk")
	else:
		velocity = Vector2.ZERO
		sprite.play("idle")

	move_and_slide()
