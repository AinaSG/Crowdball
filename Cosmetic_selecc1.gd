extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var children = []
const COUNTER = 1.5
var done_counter = COUNTER

func _ready():
	children = get_children()
	while children.size() > 4:
		children.pop_back()
	
func _process(delta):
	var all_done = true
	
	for child in children:
		if child.choosing:
			all_done = false
			break
			
	if all_done:
		done_counter -= delta
		if done_counter <= 0:
			start_game()
	else:
		done_counter = COUNTER

func start_game():
	var global = get_node("/root/buzz")
	
	for child in children:
		global.custom_players.append([child.head.current_cosmetic, child.body.current_cosmetic])
	print(global.custom_players)
	get_tree().change_scene("res://main.tscn")