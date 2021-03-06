extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var char_custom = get_node("../../../")
onready var global = get_node("/root/buzz")

var current_cosmetic = 0
var max_cosmetic = 1

func check_input():
	if (not char_custom.choosing): return
	if (char_custom.playerid >= BuzzControllerManager.get_num_players()): return
	var buttons = BuzzControllerManager.get_buttons_just_pressed_player(char_custom.playerid)
	
	if (buttons[4]): #groc, baixa
		current_cosmetic = current_cosmetic - 1
		if (current_cosmetic < 0): current_cosmetic = global.max_bods - 1
		update_cosmetic()
	if (buttons[3]): #verd, puja
		current_cosmetic = current_cosmetic + 1
		if (current_cosmetic >= global.max_bods): current_cosmetic = 0
		update_cosmetic()
	
func update_cosmetic():
	self.texture = global.bod_cosm[current_cosmetic]

func _process(delta):
	check_input()
#	pass
