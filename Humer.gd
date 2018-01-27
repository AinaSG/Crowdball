extends RigidBody2D

export(int) var player_id
export(int) var torque

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if(Input.is_key_pressed(KEY_Q)):
		set_applied_torque(20000)
	elif(Input.is_key_pressed(KEY_W)):
		set_applied_torque(-20000)
	else:
		set_applied_torque(0)