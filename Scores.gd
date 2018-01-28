extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	get_node("LabelOrange").add_color_override("font_color", Color8(255,195,130))
	get_node("LabelBlue").add_color_override("font_color", Color8(130,190,230))
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
