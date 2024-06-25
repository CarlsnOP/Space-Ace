extends Node2D


func _ready():
	ScoreManager.reset_score()

func _process(_delta):
	if Input.is_key_label_pressed(KEY_ESCAPE) == true:
		GameManager.load_main_scene()

