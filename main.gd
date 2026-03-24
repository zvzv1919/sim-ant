extends Node2D

var DotScene = preload("res://dot.tscn")

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var dot = DotScene.instantiate()
			dot.position = event.position
			add_child(dot)
