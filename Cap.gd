extends Node2D


# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const Crani = preload("res://Crani.tscn")
var crani

onready var persona = get_node("../..")
onready var timer = get_node("Timer")


func _ready():
	BuzzControllerManager.set_light_player(persona.player_id, false)
	spawn_crani()

func launch_head():
	print("launching %d" % persona.player_id)
	crani.launch()
	BuzzControllerManager.set_light_player(persona.player_id, false)
	
	persona.disconnect("head_shot", self, "launch_head")
	timer.start()
	
func spawn_crani():
	print("Spawn %d" % persona.player_id)
	crani = Crani.instance()
	add_child(crani)
	BuzzControllerManager.set_light_player(persona.player_id, true)
	persona.connect("head_shot", self, "launch_head")