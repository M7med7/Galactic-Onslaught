extends CharacterBody2D


const SPEED = 300.0
@export var bullet_scene : PackedScene
@onready var gun_point: Marker2D = $GunPoint
@export var health : int = 100
@export var move_speed : int = 50
@export var shoot_timer : float = 1.0
var shoot_timer_node: Timer
@onready var enemy_laser_shot: AudioStreamPlayer2D = $EnemyLaserShot


func _ready() -> void:
	shoot_timer_node = Timer.new()
	shoot_timer_node.wait_time = shoot_timer
	shoot_timer_node.autostart = true
	shoot_timer_node.one_shot = false
	shoot_timer_node.timeout.connect(shoot)
	add_child(shoot_timer_node)
	await get_tree().create_timer(0.5).timeout #time from each enemy bullet shoot
	start_shooting()
	
	
func _physics_process(delta: float) -> void:
	position.x += move_speed * delta
	position.y += 100 * delta
	if position.x < 50 or position.x > 550:
		move_speed *= -1 # switch side
	if position.y > 10000: #off the screen
		queue_free()
	var collision = move_and_collide(Vector2.ZERO)
	if collision:
		var collider = collision.get_collider()
		if collider.is_in_group("Player"):
			collider.take_damage(50) # if player ship collided with enemy ship then damage the player 50
			queue_free()	

func start_shooting():
	shoot_timer_node.start()
	
func shoot():
	var bullet1 = bullet_scene.instantiate()
	bullet1.position = gun_point.global_position
	get_tree().current_scene.add_child(bullet1)
	enemy_laser_shot.play()

func enemy_take_damage(damage : int) -> void:
	if health <= 0:
		return
		
	health -= damage
	if health <= 0:
		GlobalScore.increase_score(1)
		queue_free()
		
