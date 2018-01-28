extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var char_custom = get_node("../../../")
var head_cosm = []
var current_cosmetic = 0
var max_cosmetic = 1

func check_input():
	if (char_custom.playerid >= BuzzControllerManager.get_num_players()): return
	var buttons = BuzzControllerManager.get_buttons_just_pressed_player(char_custom.playerid)
	
	if (buttons[1]): #groc, baixa
		current_cosmetic = current_cosmetic - 1
		if (current_cosmetic < 0): current_cosmetic = max_cosmetic - 1
		update_cosmetic()
	if (buttons[2]): #verd, puja
		current_cosmetic = current_cosmetic + 1
		if (current_cosmetic >= max_cosmetic): current_cosmetic = 0
		update_cosmetic()
	
func update_cosmetic():
	self.texture = head_cosm[current_cosmetic]

func dir_contents(path):
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
					head_cosm.append(load(path+file_name))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

func _ready():
	dir_contents("res://head_cosmetics/")
	max_cosmetic = head_cosm.size()
	pass

func _process(delta):
	check_input()