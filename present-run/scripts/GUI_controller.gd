extends CanvasLayer

func _ready():
	var new_text = ("TIME: %03d" % GlobalVars.time_left_in_level)
	$"Interface/HBoxContainer/TimerLabel".text = new_text

func _on_Present_score_changed():
	var new_text = ("SCORE: %d" % GlobalVars.score)
	$"Interface/HBoxContainer/ScoreLabel".text = new_text


func _on_TimeLeft_timeout():
	GlobalVars.time_left_in_level -= 1
	var new_text = ("TIME: %03d" % GlobalVars.time_left_in_level)
	$"Interface/HBoxContainer/TimerLabel".text = new_text
	# If the timer runs out, restart the level
	if(GlobalVars.time_left_in_level == 0):
		get_tree().reload_current_scene()
		GlobalVars.time_left_in_level = 120


func _on_Chimney_game_win():
	get_tree().paused = true
	$Panel.visible = true
	$"Panel/MarginContainer/VBoxContainer/ScoreText".set_text("your score: %d presents" % GlobalVars.score)
	$"Panel/MarginContainer/VBoxContainer/TimeText".set_text("your time: %d seconds" % (120-GlobalVars.time_left_in_level))

func _on_PlayAgainButton_pressed():
	get_tree().reload_current_scene()


func _on_QuitButton_pressed():
	get_tree().quit()
