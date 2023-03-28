extends Node2D

var state_stack : Array
var current_state setget , _get_current_state

func _init():
	state_stack = []

func _get_current_state():
	if state_stack.size() > 0:
		return state_stack.back()
	else:
		return null


func _physics_process(delta):
	#print("Right: ", Input.is_action_pressed("move-right"), " Left: ", Input.is_action_pressed("move-left"))
	if self.current_state and self.current_state.has_method("update_state"):
		self.current_state.update_state(delta)


func push_state(state_node):
	if self.current_state != state_node:
		state_stack.push_back(state_node)
		
		if(state_node.has_method("begin_state")):
			state_node.begin_state()

func pop_state():
	var state_node = state_stack.pop_back()
	
	if(state_node.has_method("end_state")):
		state_node.end_state()
	if(state_stack.size() > 0 and self.current_state.has_method("begin_state")):
		self.current_state.begin_state()

# Pops the current state and pushes a new one
func switch_states(state_node):
	self.pop_state()
	self.push_state(state_node)