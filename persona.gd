extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var player_id = -1
const HUMER_VEL = 10
const RADI_VEL = 8
const IDLE_ANGULAR_DAMP = 200.0

onready var humer_d = get_node("B_Dret/Humer")
onready var humer_e = get_node("B_Esquerra/Humer")

onready var radi_d = get_node("B_Dret/Humer/Radi")
onready var radi_e = get_node("B_Esquerra/Humer/Radi")

onready var pin_joint_humer_e = get_node("B_Esquerra/Humer/PinJoint2D")
onready var pin_joint_radi_e = get_node("B_Esquerra/Humer/Radi/PinJoint2D")

enum Direction { UP, DOWN }

func _ready():
	print("player %d ready" % player_id)
	pin_joint_humer_e.softness = 1
	pin_joint_radi_e.softness = 1
	
func _process(delta):
	var buttons = BuzzControllerManager.get_buttons_player(player_id)
	
	if buttons[1]: # blue   (P)
		radi_active(Direction.UP)
	elif buttons[2]: # orange (O)
		radi_active(Direction.DOWN)
	else:
		radi_idle()
	
	if buttons[3]: # green  (W)
		humer_active(Direction.UP)
	elif buttons[4]: # yellow (Q)
		humer_active(Direction.DOWN)
	else:
		humer_idle()
		

func radi_active(direction):
	radi_d.angular_damp = 0.0
	radi_e.angular_damp = 0.0
	
	radi_d.angular_velocity = ( 1 if direction == Direction.UP else -1) * RADI_VEL
	radi_e.angular_velocity = (-1 if direction == Direction.UP else  1) * RADI_VEL
	
func radi_idle():
	radi_d.angular_damp = IDLE_ANGULAR_DAMP
	radi_e.angular_damp = IDLE_ANGULAR_DAMP
	
func humer_active(direction):
	humer_d.angular_damp = 0.0
	humer_e.angular_damp = 0.0
	
	humer_d.angular_velocity = ( 1 if direction == Direction.UP else -1) * HUMER_VEL
	humer_e.angular_velocity = (-1 if direction == Direction.UP else  1) * HUMER_VEL
	
func humer_idle():
	humer_d.angular_damp = IDLE_ANGULAR_DAMP
	humer_e.angular_damp = IDLE_ANGULAR_DAMP