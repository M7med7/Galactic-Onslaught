extends Node2D


@export var speed : int = 400
@export var direction: Vector2 = Vector2(0, -1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta * -1
	
	# Destroy if it goes off screen
	if position.y > get_viewport_rect().size.y + 300:
		queue_free()
