extends Area2D

signal game_win

func _on_Chimney_body_entered(body):
	var tween = get_node("Tween")
	var player = $"/root/Level/Player"
	# Make sure that the player's states are cleared, that they can't run/jump
	player.get_node("States").state_stack = []
	player.get_node("AnimatedSprite").animation = "idle"
	tween.interpolate_property(player, "position",
        Vector2(position.x, player.position.y), 
		Vector2(position.x, position.y+GlobalVars.TILESIZE*1), 3,
        Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()


func _on_Tween_tween_completed(object, key):
	emit_signal("game_win")
