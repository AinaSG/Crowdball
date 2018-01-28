extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var goals_blue = 0
var goals_orange = 0
onready var Balls = get_node("../Balls")

func _ready():
	
	pass
	
func handle_goal(ball, team):
	ball.queue_free()
	if team == "orange":
		goals_orange += 1
		Balls.spawn_ball(Balls.LEFT_SPAWN)
	elif team == "blue":
		goals_blue += 1
		Balls.spawn_ball(Balls.RIGHT_SPAWN)
		
	print("blue %d - %d orange" % [goals_blue, goals_orange])