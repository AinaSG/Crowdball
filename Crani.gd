extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func launch():
	var p1 = global_position
	var p2 = to_global(Vector2(0,-1))
	var global_direction = (p2 - p1).normalized()
	
	position = global_position
	rotation = global_rotation
	set_as_toplevel(true)
	mode = RigidBody2D.MODE_RIGID
	apply_impulse(Vector2(0,0), global_direction * 700)