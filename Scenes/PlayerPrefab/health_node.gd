extends Node

@onready var player : CharacterBody3D = get_parent()
@export_range(1,200,1) var max_health = 100

var health: int:
	get:
		return health
	set(value):
		pass

func hit(damage) -> void:
	health -= damage
	health = clamp(health, 0, max_health)
	if health <= 0:
		die()

func die() -> void:
	pass
