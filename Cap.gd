extends Node2D


# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const Crani = preload("res://Crani.tscn")
var crani
var head_cosmetic = -1 setget set_cosmetic

onready var persona = get_node("../..")
onready var timer = get_node("Timer")


func _ready():
	BuzzControllerManager.set_light_player(persona.player_id, false)
	spawn_crani()

func launch_head():
	crani.launch()
	BuzzControllerManager.set_light_player(persona.player_id, false)
	
	persona.disconnect("head_shot", self, "launch_head")
	timer.start()
	
func spawn_crani():
	crani = Crani.instance()
	crani.cosmetic = head_cosmetic
	add_child(crani)
	BuzzControllerManager.set_light_player(persona.player_id, true)
	persona.connect("head_shot", self, "launch_head")
	
func set_cosmetic(c):
	
	var global = get_node("/root/buzz")
	
	head_cosmetic = c
	if crani != null:
		crani.cosmetic = head_cosmetic
		crani.get_node("Custom").texture = global.head_cosm[head_cosmetic]
	