extends Node2D

var Ball = preload("res://Ball.tscn")

const MIDDLE_SPAWN = Vector2(700,        -450)
const LEFT_SPAWN   = Vector2(450,        -360)
const RIGHT_SPAWN  = Vector2(1400 - 450, -360)

func _ready():
	spawn_ball(MIDDLE_SPAWN)
	spawn_ball(RIGHT_SPAWN)
	spawn_ball(LEFT_SPAWN)
	pass

func spawn_ball(pos):
	var b = Ball.instance()
	b.position = pos
	add_child(b)
