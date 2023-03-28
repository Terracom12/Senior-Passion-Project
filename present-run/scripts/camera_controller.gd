extends Camera2D

func _process(delta):
	if(get_camera_position().y >= 6):
		position.y = -(get_parent().position.y/2)