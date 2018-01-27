extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var char_custom = get_node("../../")

var blue_bg = preload("res://blue_bg_dark.png")
var orange_bg = preload("res://orange_bg_dark.png")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	if(char_custom.team == 1):
		self.texture = blue_bg
	else:
		self.texture = orange_bg
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
