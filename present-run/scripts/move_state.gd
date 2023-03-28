extends Node2D

onready var stateMachine = get_parent()
onready var player = get_owner()

export(float) var movementSpeed = GlobalVars.TILESIZE * 1.5

func begin_state():
	player.get_node("AnimatedSprite").animation = "move"

func update_state(delta):
	if(Input.is_action_just_pressed("jump")):
		stateMachine.push_state(get_node("../Jump"))
	
	var input = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	if(input == 0):
		stateMachine.switch_states(get_node("../Idle"))
	elif(input == -1):
		player.flipped = true
	else:
		player.flipped = false
	
	if(Input.is_key_pressed(KEY_SHIFT)):
		input *= 1.5
		player.get_node("AnimatedSprite").speed_scale = 1.5
	else:
		player.get_node("AnimatedSprite").speed_scale = 1
	
	player.move_and_slide_with_snap(Vector2(input * movementSpeed, (get_node("../Jump").gravity*delta)), Vector2(0, 32), Vector2.UP, true)
	if(not player.is_on_floor()):
		stateMachine.push_state(get_node("../Fall"))