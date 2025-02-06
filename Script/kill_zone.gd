extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):  # Check if it's the Player
		body.take_damage(5)  # enemy bullet damage
		queue_free()
	elif body.is_in_group("Enemy"):
		body.enemy_take_damage(50) # player bullet damage
