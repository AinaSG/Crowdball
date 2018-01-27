extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	BuzzControllerManager.init()

func _process(delta):
	BuzzControllerManager.update_inputs()