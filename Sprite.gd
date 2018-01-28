extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var character = get_node("../../")

var blue_bod = preload("res://blue_bod.png")
var orange_bod = preload("res://orange_bod.png")

func _ready():
	if(character.team == 1):
		self.texture = blue_bod
	else:
		self.texture = orange_bod
	pass
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
