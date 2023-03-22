extends RigidBody2D

func _ready():
	$AnimatedSprite2D.play()
	$AnimatedSprite2D.animation = Array($AnimatedSprite2D.get_sprite_frames().get_animation_names()).pick_random()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
