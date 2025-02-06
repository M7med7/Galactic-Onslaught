extends Node
var score : int =0
var last_score = 0  # Store the last score when the player dies
var best_score: int = 0
const SAVE_PATH = "user://score_data.save"
var UI : Control = null

func _ready():
	load_best_score()

func increase_score(amount : int):
	score += amount
	if UI:
		UI.update_score(score)
		
func reset_score():
	save_best_score()
	last_score = score
	score = 0

func save_best_score():
	if score > best_score:
		best_score = score 
		var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
		file.store_var(best_score)
		file.close()
		
func load_best_score():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		best_score = file.get_var()
		file.close()
