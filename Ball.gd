extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var ayy = "lmao"

func _ready():
	randomize()
	rotation_degrees = rand_range(0,360)
