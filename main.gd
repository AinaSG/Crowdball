extends Node2D

var Persona = preload("res://persona.tscn")

func _ready():
	randomize()
	var screenSize = get_viewport().size
	screenSize.x = 1400
	var availableSpace = screenSize.x / 12
	print(availableSpace)
	for i in range(12):
		var p = Persona.instance()
		p.position.x = i * availableSpace + availableSpace/2
		p.position.y = 0
		p.player_id = i
		add_child(p)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
