extends Node2D
class_name Ant

var speed := 200.0

func _draw():
	pass

func _process(delta):
	position.x += speed * delta
	if position.x > get_viewport_rect().size.x + 20:
		queue_free()
