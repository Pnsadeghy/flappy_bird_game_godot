extends CanvasLayer

signal start_game

var game_start = false

func _process(delta):
	if !game_start and Input.is_action_just_pressed("flap"):
		game_start = true
		start_game.emit()
		$StartMenu.visible = false

func game_over(score, high_score):
	$GameOverMenu.visible = true
	
	$GameOverMenu/VBoxContainer/ScoreLabel.text = "SCORE: " + str(score)
	$GameOverMenu/VBoxContainer/HighScoreLabel.text = "BEST: " + str(high_score)


func _on_restart_button_pressed():
	get_tree().reload_current_scene()
