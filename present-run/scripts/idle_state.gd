extends Node2D

onready var stateMachine = get_parent()
onready var player = get_owner()

func _init():
	print("called")

func _ready():
	stateMachine.push_state(self)
	print("ready")

func begin_state():
	player.move_and_slide(Vector2(0, 0.1), Vector2.UP)
	if(not player.is_on_floor()):
		stateMachine.push_state(get_node("../Fall"))
		return
	player.get_node("AnimatedSprite").animation = "idle"

func update_state(delta):
	if((Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")) and
		not (Input.is_action_pressed("move_left") and Input.is_action_pressed("move_right"))):
		stateMachine.switch_states(get_node("../Move"))
	elif(Input.is_action_just_pressed("jump")):
		 stateMachine.push_state(get_node("../Jump"))