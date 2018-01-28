extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var cosmetic = -1
onready var global = get_node("/root/buzz")

func _ready():
	if global.max_heads > cosmetic:
		get_node("Custom").texture = global.head_cosm[cosmetic]
	

func launch():
	var p1 = global_position
	var p2 = to_global(Vector2(0,-1))
	var global_direction = (p2 - p1).normalized()
	
	position = global_position
	rotation = global_rotation
	set_as_toplevel(true)
	mode = RigidBody2D.MODE_RIGID
	apply_impulse(Vector2(0,0), global_direction * 700)