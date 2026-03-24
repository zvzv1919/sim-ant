extends Node2D

var speed := 200.0

func _draw():
	draw_circle(Vector2.ZERO, 8.0, Color.RED)

func _process(delta):
	position.x += speed * delta
	if position.x > get_viewport_rect().size.x + 20:
		queue_free()
