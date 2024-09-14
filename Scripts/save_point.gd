extends Node2D

@onready var player : Node2D = %Player
@onready var particle_emitter : GPUParticles2D = $ParticleEmitter

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("game_a") && player.global_position.distance_squared_to(global_position) <= 16*16:
		save()

func save() -> void:
	particle_emitter.restart()
	particle_emitter.emitting = true
	pass
