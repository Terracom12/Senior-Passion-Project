extends Node2D

onready var stateMachine = get_parent()
onready var player = get_owner()

var current_velocity: Vector2

func begin_state():
	if player == null:
		player = get_owner()
	player.get_node("AnimatedSprite").animation = "fall"

func update_state(delta):
	if(player.is_on_floor()):
		current_velocity = Vector2.ZERO
		stateMachine.pop_state()
	current_velocity.x = $"../Jump".horizontal_motion(delta)
	current_velocity.y += ($"../Jump".gravity) * delta
	
	player.move_and_slide(current_velocity, Vector2.UP)