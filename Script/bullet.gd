extends Area2D


@export var speed : int = 600 # Bullet speed
@export var direction: Vector2 = Vector2(0, -1)  # Moves up


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta
	
	# Destroy if it goes off screen
	if position.y > get_viewport_rect().size.y:
		queue_free()
