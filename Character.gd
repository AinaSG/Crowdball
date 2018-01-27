extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var up_pos = Vector2(0.0, -10.0)
var down_pos = Vector2(0.0, 0.0)

var going_up = true
var jump_speed = 0.5

onready var TweenNode = get_node("Tween")

func go_up():
	TweenNode.interpolate_property(self, "position", position, up_pos, jump_speed, Tween.TRANS_QUINT,Tween.EASE_IN)
	TweenNode.interpolate_callback(self, TweenNode.get_runtime(), "Call", "true")
	TweenNode.start()
	
func go_down():
	TweenNode.interpolate_property(self, "position", position, down_pos, jump_speed, Tween.TRANS_QUINT,Tween.EASE_OUT)
	TweenNode.interpolate_callback(self, TweenNode.get_runtime(), "Call", "false")
	TweenNode.start()
	
func Call(go_down_):
	if (go_down_ == "true"):
		go_down()
	else:
		go_up()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	TweenNode.interpolate_callback(self, rand_range(0,1), "go_up")
	TweenNode.start()
	#call_deferred("go_up()")
	#go_up()	
	pass

func _process(delta):	

	pass
