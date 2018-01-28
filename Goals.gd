extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

signal won(team)

const SCORES_TO_WIN = 1

var goals_blue = 0
var goals_orange = 0
onready var Balls = get_node("../Balls")
onready var Scores = get_node("../Scores")
onready var Timer = get_node("Timer")

export(NodePath) var score_blue_
export(NodePath) var score_orange_

var score_orange
var score_blue

var wonnered = false

func _ready():
	score_orange = get_node(score_orange_)
	score_blue = get_node(score_blue_)
	pass
	
func handle_goal(ball, scoring_team):
	if ball.ayy == null or wonnered: return
	
	ball.queue_free()
	if scoring_team == "orange":
		goals_orange += 1
		Balls.spawn_ball(Balls.RIGHT_SPAWN)
	elif scoring_team == "blue":
		goals_blue += 1
		Balls.spawn_ball(Balls.LEFT_SPAWN)
		
	score_orange.text = str(goals_orange)
	score_blue.text = str(goals_blue)
	
	if goals_orange >= SCORES_TO_WIN:
		wonnered = true
		Scores.show_win("orange")
		emit_signal("won", 1)
		Timer.start()
	elif goals_blue >= SCORES_TO_WIN:
		wonnered = true
		Scores.show_win("blue")
		emit_signal("won", 2)
		Timer.start()
		
	print("blue %d - %d orange" % [goals_blue, goals_orange])
	