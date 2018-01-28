extends Node2D

var Persona = preload("res://persona.tscn")
onready var Goals = get_node("Goals")

func _ready():
	randomize()
	
	var screenSize = get_viewport().size
	screenSize.x = 1400
	var availableSpace = screenSize.x / 12

	var global = get_node("/root/buzz")

	for i in range(12):
		var p = Persona.instance()
		p.position.x = i * availableSpace + availableSpace/2
		p.position.y = 0
		p.player_id = i
		if ( i == 0 or i == 1 or i == 3 or i == 5 or i == 7 or i == 9):
			p.team = 1
		else:
			p.team = 2
		
		add_child(p)
		
		Goals.connect("won", p, "celebrate")
		
		if i < global.custom_players.size():
			p.set_customization(global.custom_players[i])
			
func reset_game():
	get_tree().change_scene("res://Cosmetic_selecc1.tscn")

