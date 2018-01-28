extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var playerid = -1
export var team = 1 # 1 = blue 2 = orange
export var choosing = true
onready var moving_char = get_node("Character")
onready var head = get_node("Character/Head_node/Head_cosmetic")
onready var body = get_node("Character/Body_node/Body_cosmetic")

func _ready():
	# Called every time the node is added to the scene.
	if (playerid < BuzzControllerManager.get_num_players()):
		BuzzControllerManager.set_light_player(playerid,true)

func _process(delta):
	if (playerid >= BuzzControllerManager.get_num_players()): return
	var buttons = BuzzControllerManager.get_buttons_just_pressed_player(playerid)
	
	if buttons[0]:
		choosing = not choosing
		moving_char.active = choosing
		BuzzControllerManager.set_light_player(playerid, choosing)
		
	pass