extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const BLUE =  Color8(130,190,230)
const ORANGE =  Color8(255,195,130)

onready var bluewins = get_node("BlueWins")
onready var orangewins = get_node("OrangeWins")

func _ready():
	set_style(get_node("LabelBlue"),BLUE)
	set_style(get_node("LabelOrange"),ORANGE)
	
	set_style(bluewins,BLUE)
	bluewins.hide()
	set_style(orangewins,ORANGE)
	orangewins.hide()

func set_style(node, color):
	node.add_color_override("font_color",color)
	node.add_color_override("font_color_shadow", Color8(255,255,255))
	node.add_constant_override("shadow_as_outline", 10)
	
func show_win(team):
	if team == "orange":
		orangewins.show()
	elif team == "blue":
		bluewins.show()
