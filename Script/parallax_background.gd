extends ParallaxBackground

@onready var back_ground_space: ParallaxLayer = %BackGroundSpace

var scroll_speed : int = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		back_ground_space.motion_offset.y += scroll_speed * delta # Moves the background down
	
