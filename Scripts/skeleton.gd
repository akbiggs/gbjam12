extends CharacterBody2D

const SPEED = 20.0
@onready var player = %Player

func _physics_process(delta: float) -> void:
	var direction = (player.position - position).normalized()
	velocity = direction * SPEED
	
	move_and_slide()
