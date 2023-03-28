extends Node2D

onready var stateMachine = get_parent()
onready var player = get_owner()

export(float) var horizontalAirControl = GlobalVars.TILESIZE * 2
export(float) var maxJumpHeight = GlobalVars.TILESIZE * 1.5
export(float) var minJumpHeight = GlobalVars.TILESIZE * 0.75
export(float) var timeToPeak = 0.8

var gravity: float
var jumpVelocity: float
var earlyTerminationJumpVelocity: float

var jumpButtonPressed: bool = false

func _ready():
	calculate_vars()

func begin_state():
	player.get_node("AnimatedSprite").animation = "jump"
	player.get_node("JumpSoundPlayer").volume_db = GlobalVars.sound_volume
	player.get_node("JumpSoundPlayer").play()
	# This timer is because for one or two frames, the player is still 
	# considered to be on the ground, even after jumping
	$JumpDelayTimer.wait_time = 0.1
	$JumpDelayTimer.start()
	
	jumpButtonPressed = true
	
	calculate_vars()

func calculate_vars():
	"""
	Using kinematic equations to determine gravity,
	jumpVelocity, and earlyTerminationJumpVelocity
	(when the jump key is let go of early)
	Source for equations: 
	https://error454.com/2013/10/23/platformer-physics-101-and-the-3-fundamental-equations-of-platformers/
	"""
	# 2·maxHeight∕jumpTime²: fall twice as fast as you go up
	gravity = (2*maxJumpHeight)/pow(timeToPeak, 2)
	
	# √2×gravity×maxHeight
	jumpVelocity = -sqrt(2*gravity*maxJumpHeight)
	
	# √v²+2×gravity(maxHeight-minHeight)
	earlyTerminationJumpVelocity = -sqrt(pow(jumpVelocity, 2)+
		(2*(-gravity)*(maxJumpHeight-minJumpHeight)))

func update_state(delta):
	if(player.is_on_floor() && $JumpDelayTimer.time_left == 0):
		stateMachine.pop_state()
	if(Input.is_action_just_released("jump")):
		jumpButtonPressed = false
	var currentVelocity: Vector2
	currentVelocity.x = horizontal_motion(delta)
	currentVelocity.y = vertical_motion(delta)
	
	player.move_and_slide(currentVelocity, Vector2.UP)


func vertical_motion(delta):
	# If the players hits their head then we want them to stop jumping
	if(player.is_on_ceiling()):
		jumpVelocity = 0
	
	if(jumpButtonPressed):
		jumpVelocity += gravity * delta
		return jumpVelocity
	else:
		jumpVelocity += gravity * delta
		earlyTerminationJumpVelocity += gravity * delta
		return max(jumpVelocity, earlyTerminationJumpVelocity)
	
func horizontal_motion(delta):
	var input = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	
	if(input == -1):
		player.flipped = true
	elif(input == 1):
		player.flipped = false
	
	return input * horizontalAirControl