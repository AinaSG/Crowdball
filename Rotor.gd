extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var direction = 1
const SPEED = 4

func _ready():
	angular_velocity = SPEED * direction

func _process(delta):
	angular_velocity = SPEED * direction