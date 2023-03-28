extends KinematicBody2D

onready var flipped = false setget _set_flipped

func _set_flipped(value):
	if((value and not flipped) or (not value and flipped)):
		flipped = value
		scale.x *= -1

func _on_DeathArea_body_exited(body):
	get_tree().reload_current_scene()
	GlobalVars.time_left_in_level = 120
