extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var goals_blue = 0
var goals_orange = 0
onready var Balls = get_node("../Balls")
export(NodePath) var score_blue_
export(NodePath) var score_orange_

var score_orange
var score_blue

func _ready():
	score_orange = get_node(score_orange_)
	score_blue = get_node(score_blue_)
	pass
	
func handle_goal(ball, receiving_team):
	ball.queue_free()
	if receiving_team == "orange":
		goals_blue += 1
		Balls.spawn_ball(Balls.LEFT_SPAWN)
	elif receiving_team == "blue":
		goals_orange += 1
		Balls.spawn_ball(Balls.RIGHT_SPAWN)
		
	score_orange.text = str(goals_orange)
	score_blue.text = str(goals_blue)
		
	print("blue %d - %d orange" % [goals_blue, goals_orange])