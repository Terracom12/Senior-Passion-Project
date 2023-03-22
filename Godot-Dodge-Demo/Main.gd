extends Node

@export var mob_scene: PackedScene
var score


func _ready():
	new_game()

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()


func _on_start_timer_timeout():
	$MobTimer.start()


func _on_score_timer_timeout():
	score += 1

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	
	$MobPath/MobSpawnLocation.progress_ratio = randf_range(0.0, 1.0)
	var spawn_location = $MobPath/MobSpawnLocation.position
	
	mob.position = spawn_location
	mob.rotation = $MobPath/MobSpawnLocation.rotation + randf_range(PI/4, 3*PI/4) 
	
	mob.linear_velocity = Vector2(randf_range(150,250),0).rotated(mob.rotation)
	
	add_child(mob)
	
