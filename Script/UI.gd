extends Control

@onready var score_label: Label = $ScoreLabel

func update_score(new_score :int):
	score_label.text = "Score: " + str(new_score)
