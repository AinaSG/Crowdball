extends Sprite

onready var char_custom = get_node("../../../")

var blue_bod = preload("res://blue_bod.png")
var orange_bod = preload("res://orange_bod.png")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	if(char_custom.team == 1):
		self.texture = blue_bod
	else:
		self.texture = orange_bod
	pass
