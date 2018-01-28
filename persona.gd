extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var player_id = -1
export var team = 1

const HUMER_VEL = 10
const RADI_VEL = 8
const IDLE_ANGULAR_DAMP = INF
const SOFTNESS = -0.001
const BIAS = 0.9
const SWING_DEGREES = 50
const SWING_SPEED = 0.5

onready var humer_d = get_node("B_Dret/Humer")
onready var humer_e = get_node("B_Esquerra/Humer")

onready var radi_d = get_node("B_Dret/Humer/Radi")
onready var radi_e = get_node("B_Esquerra/Humer/Radi")

onready var body = get_node("Cos")

onready var pin_joint_humer_e = get_node("B_Esquerra/Humer/PinJoint2D")
onready var pin_joint_radi_e = get_node("B_Esquerra/Humer/Radi/PinJoint2D")
onready var pin_joint_humer_d = get_node("B_Dret/Humer/PinJoint2D")
onready var pin_joint_radi_d = get_node("B_Dret/Humer/Radi/PinJoint2D")

signal head_shot

enum Direction { UP, DOWN }
var swing_dir = 1
var swing_alpha = 0

func _ready():
	pin_joint_humer_e.softness = SOFTNESS
	pin_joint_radi_e.softness  = SOFTNESS
	pin_joint_humer_d.softness = SOFTNESS
	pin_joint_radi_d.softness  = SOFTNESS
	
	pin_joint_humer_e.bias = BIAS
	pin_joint_radi_e.bias  = BIAS
	pin_joint_humer_d.bias = BIAS
	pin_joint_radi_d.bias  = BIAS
	
	var l = 1 << (player_id + 3)
	body.layers = l
	humer_e.collision_mask |= l
	radi_e.collision_mask  |= l
	humer_d.collision_mask |= l
	radi_d.collision_mask  |= l
	pass
	
func _process(delta):
	check_input()
	
	swing_alpha += SWING_SPEED * swing_dir * delta
	if swing_alpha > 1 or swing_alpha < -1:
		swing_dir *= -1
		swing_alpha = clamp(swing_alpha,-1,1)
	
	body.rotation_degrees = cos(swing_alpha * 2 * PI) * SWING_DEGREES/2	
	body.position.y = (sin(swing_alpha * 1.1 * 2 * PI + (player_id * PI/4)) * 0.5 + 0.5) * -5
	
func check_input():
	if (player_id >= BuzzControllerManager.get_num_players()): return
	arm_movement()
	
	var big_red_button_just_pressed = BuzzControllerManager.get_buttons_just_pressed_player(player_id)[0]
	if big_red_button_just_pressed:
		emit_signal("head_shot")
	
func arm_movement():
	var buttons = BuzzControllerManager.get_buttons_player(player_id)
	
	if buttons[1]: # blue   (P)
		radi_active(Direction.UP)
	elif buttons[2]: # orange (O)
		radi_active(Direction.DOWN)
	else:
		radi_idle()
	
	if buttons[3]: # green  (W)
		humer_active(Direction.DOWN)
	elif buttons[4]: # yellow (Q)
		humer_active(Direction.UP)
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
	
func set_customization(indexes):
	var global = get_node("/root/buzz")
	var custom_body = get_node("Cos/Custom")
	var custom_head = get_node("Cos/Cap")
	custom_head.head_cosmetic = indexes[0]
	custom_body.texture = global.bod_cosm[indexes[1]]
	print(indexes)
