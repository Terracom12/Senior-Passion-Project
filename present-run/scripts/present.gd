extends Area2D

signal score_changed

func _on_Present_body_entered(body):
	$PresentSoundPlayer.volume_db = GlobalVars.sound_volume
	$PresentSoundPlayer.play(1.6)
	GlobalVars.score+=1
	emit_signal("score_changed")
	monitoring = false
	var tween_pos = Tween.new()
	tween_pos.interpolate_property(self, "position",
        Vector2(position.x, position.y), 
		Vector2(position.x, position.y-GlobalVars.TILESIZE*0.5), 0.75,
        Tween.TRANS_LINEAR, Tween.EASE_IN)
	var tween_opacity = Tween.new()
	tween_opacity.interpolate_property($"sprite", "modulate",
        Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.75,
        Tween.TRANS_LINEAR, Tween.EASE_IN)
	add_child(tween_pos)
	add_child(tween_opacity)
	tween_pos.start()
	tween_opacity.start()
	
	yield(tween_opacity, "tween_completed")
	queue_free()
