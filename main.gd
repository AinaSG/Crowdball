extends Node2D

var Persona = preload("res://persona.tscn")

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
		
		add_child(p)
		
		if i < global.custom_players.size():
			p.set_customization(global.custom_players[i])
		
		
