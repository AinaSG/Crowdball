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

onready var body = get_node("Cos")

onready var pin_joint_humer_e = get_node("B_Esquerra/Humer/PinJoint2D")
onready var pin_joint_radi_e = get_node("B_Esquerra/Humer/Radi/PinJoint2D")

enum Direction { UP, DOWN }
var swing_dir = 1
var target_rotation_degrees = 0

func _ready():
	print("player %d ready" % player_id)
	pin_joint_humer_e.softness = 1
	pin_joint_radi_e.softness = 1
	#body.angular_damp = INF
	
func _process(delta):
	check_input()
	
	target_rotation_degrees += 5 * swing_dir * delta
	if target_rotation_degrees > 25 or target_rotation_degrees < -25:
		swing_dir *= -1
		
	#body.angular_velocity = 2 * body.rotation_degrees / (target_rotation_degrees) 
	
	
func check_input():
	if (player_id >= BuzzControllerManager.get_num_players()): return
	var buttons = BuzzControllerManager.get_buttons_player(player_id)
	
	arm_movement(buttons)
	head_shot(buttons)
	
func head_shot(buttons):
	if buttons[0]:
		print("PINYAU")
	
func arm_movement(buttons):
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