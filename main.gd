extends Node2D

var Persona = preload("res://persona.tscn")
const PERSONA_WIDTH = 500

func _ready():
	var screenSize = get_viewport().size
	
	position = Vector2(0, screenSize.y)
	
	var availableSpace = screenSize.x / 12
	print(availableSpace)
	for i in range(12):
		
		var p = Persona.instance()
		add_child(p)
		
		var s = availableSpace/PERSONA_WIDTH
		print(s)
		p.position.x = i * availableSpace + availableSpace/2
		p.player_id = i

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
