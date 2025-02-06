extends Label

@onready var score_lable_end: Label = $"."
@onready var best_score: Label = $"../BestScore"




func _ready() -> void:
	score_lable_end.text = "Your Score: " + str(GlobalScore.last_score)
	best_score.text = "Best Score: " + str(GlobalScore.best_score)
