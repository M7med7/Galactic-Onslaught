extends CharacterBody2D


const SPEED = 400.0
@export var bullet_scene : PackedScene 
@onready var weapon_right: Marker2D = $Weapon_Right
@onready var weapon_left: Marker2D = $Weapon_Left
@export var health : int = 100
@export var health_bar: ProgressBar
@onready var laser_shot_player: AudioStreamPlayer2D = $LaserShotPlayer



func _ready():
	add_to_group("Player")

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()



func shoot():
	var bullet1 = bullet_scene.instantiate()
	var bullet2 = bullet_scene.instantiate()
	
	bullet1.position = weapon_left.global_position
	bullet2.position = weapon_right.global_position
	
	get_tree().current_scene.add_child(bullet1)
	get_tree().current_scene.add_child(bullet2)
	laser_shot_player.play()

func take_damage(damage: int):
	health -= damage
	update_health_bar()
	if health <= 0 :
		game_over()
		queue_free()	

func update_health_bar():
	if health_bar:
		health_bar.max_value = 100
		health_bar.value = health
		
		var health_color = Color(0,0.5,0)
		if health <50:
			health_color = Color(1, 1, 0)
		if health < 20:
			health_color = Color(1, 0, 0)
		var stylebox = StyleBoxFlat.new()
		stylebox.bg_color = health_color
		health_bar.add_theme_stylebox_override("fill",stylebox)

func game_over(): #this is not working right
	print("GAME OVER")
	GlobalScore.reset_score()  # Save the final score
	call_deferred("load_game_over_screen")
	
func load_game_over_screen():
	if get_tree():
		get_tree().change_scene_to_file("res://scene/game_over_ui.tscn")
	else:
		print("Error: Scene tree is null!")
