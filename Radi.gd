extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var pin_joint = get_node("PinJoint2D")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if(Input.is_key_pressed(KEY_O)):
		set_applied_torque(10000)
	elif(Input.is_key_pressed(KEY_P)):
		set_applied_torque(-10000)
	else:
		set_applied_torque(0)
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
