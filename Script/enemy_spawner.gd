extends Node2D

@export var enemy_scene : PackedScene
var base_value = 5.0
var min_value = 0.5  # The lowest possible value
var difficulty_factor = 0.01  # Controls how fast the number decreases

func _ready() -> void:
	add_to_group("Enemy")
	spawn_enemy()

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	enemy.position = Vector2(randi_range(50,550),200)
	get_tree().current_scene.call_deferred("add_child",enemy)
	var generated_number = max(base_value / (1 + (GlobalScore.score * difficulty_factor)), min_value)
	var random_time = randf_range(0.1,generated_number)
	print("generated number: ",generated_number)
	print(random_time)
	await get_tree().create_timer(random_time, false).timeout
	spawn_enemy()
