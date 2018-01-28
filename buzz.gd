extends Node2D

var custom_players = []
var bod_cosm = []
var head_cosm = []

var max_heads = 0
var max_bods = 0

func dir_contents(path):
	var result = []
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
				if(file_name.ends_with(".png")):
					result.append(load(path+file_name))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return result

func _ready():
	BuzzControllerManager.init()
	
	bod_cosm = dir_contents("res://bod_cosmetics/")
	head_cosm = dir_contents("res://head_cosmetics/")
	
	max_heads = head_cosm.size()
	max_bods = bod_cosm.size()

func _process(delta):
	BuzzControllerManager.update_inputs()