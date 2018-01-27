extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var alfa = 1
var up = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	for child in get_children():
		child.modulate.a = alfa
	
	if(up):
		alfa = alfa + 1 * delta
		if (alfa >= 1):
			up = false
			alfa = 1
		
	else: 
		alfa = alfa - 1 * delta
		if (alfa <= 0):
			up = true
			alfa = 0
#	pass
